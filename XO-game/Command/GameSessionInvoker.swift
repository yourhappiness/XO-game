//
//  GameSessionInvoker.swift
//  XO-game
//
//  Created by Stanislav Ivanov on 02/10/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation


// MARK: - Invoker


class GameSessionInvoker {
     
    static let shared: GameSessionInvoker = GameSessionInvoker()
  
    private var commands: [PlaceMarkCommand] = []
  
    private var timer: Timer = Timer()
    private var timeInterval: TimeInterval = 1.0
    private var index: Int = 0
  
    private var gameboard: Gameboard?
  
    func addCommand(_ command: PlaceMarkCommand) {
        self.commands.append(command)
    }
    
    func execute(gameboard: Gameboard, gameState: GameSessionExecutionState) {
      self.gameboard = gameboard
      var firstPlayerCommands: [PlaceMarkCommand] = []
      var secondPlayerCommands: [PlaceMarkCommand] = []
    
      for command in self.commands {
        switch command.player {
        case .first:
          firstPlayerCommands.append(command)
        case .second:
          secondPlayerCommands.append(command)
        }
      }
      
      var orderedCommands: [PlaceMarkCommand] = []
      
      for index in 0 ..< firstPlayerCommands.count {
        orderedCommands.append(firstPlayerCommands[index])
        orderedCommands.append(secondPlayerCommands[index])
      }
      
      self.commands = orderedCommands

      self.timer = Timer.scheduledTimer(withTimeInterval: self.timeInterval, repeats: true) { timer in
        self.commands[self.index].execute(gameboard: gameboard)
        self.index += 1
        if self.index == self.commands.count {
          timer.invalidate()
          gameState.determineWinner(gameboard: gameboard)
          self.commands.removeAll()
          self.index = 0
        }
      }
    }
}

