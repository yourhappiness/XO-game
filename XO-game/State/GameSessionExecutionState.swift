//
//  GameSessionExecutionState.swift
//  XO-game
//
//  Created by Anastasia Romanova on 06/10/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

class GameSessionExecutionState: GameState {
  
  var isCompleted: Bool = false
  
  var inputState: GameViewInput
  
  weak var gameboard: Gameboard?
  
  init(inputState: GameViewInput, gameboard: Gameboard) {
    self.inputState = inputState
    self.gameboard = gameboard
  }
  
  func begin() {
    self.inputState.firstPlayerTurnLabel(hide: true)
    self.inputState.secondPlayerTurnLabel(hide: true)
    
    guard let gameboard = self.gameboard else {return}
    GameSessionInvoker.shared.execute(gameboard: gameboard, gameState: self)
  }
  
  func addMark(at position: GameboardPosition) {}
  
  func determineWinner(gameboard: Gameboard) {
    self.inputState.winnerLabel(hide: false)
    
    var text = "No winner"
    let referee = Referee(gameboard: gameboard)
    if let winner = referee.determineWinner() {
      text = winner.winnerText()
    }
    self.inputState.winnerLabel(text: text)
  }
}
