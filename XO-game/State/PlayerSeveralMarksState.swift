//
//  PlayerInputSeveralMarksState.swift
//  XO-game
//
//  Created by Anastasia Romanova on 06/10/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation


class PlayerInputSeveralMarksState: GameState {
  
  private let batchSize: Int = 5
  
  var isCompleted: Bool = false
  
  let player: Player
  
  var inputState: GameViewInput
  
  weak var gameboard: Gameboard?
  weak var gameboardView: GameboardView?
  
  
  init(player: Player, inputState: GameViewInput, gameboard: Gameboard, gameboardView: GameboardView) {
    self.player = player
    
    self.inputState = inputState
    
    self.gameboard = gameboard
    self.gameboardView = gameboardView
  }
  
  
  // MARK: -
  
  func begin() {
    switch self.player {
    case .first:
      self.inputState.firstPlayerTurnLabel(hide: false)
      self.inputState.secondPlayerTurnLabel(hide: true)
    case .second:
      self.inputState.firstPlayerTurnLabel(hide: true)
      self.inputState.secondPlayerTurnLabel(hide: false)
    }
    
    self.inputState.winnerLabel(hide: true)
  }
  
  func addMark(at position: GameboardPosition) {
    if self.isCompleted { return }
    
    guard let gameboardView = self.gameboardView else {return}
    
    let command = PlaceMarkCommand(player: self.player,
                                   position: position,
                                   gameboardView:gameboardView)
    GameSessionInvoker.shared.addCommand(command)
    let markView = self.player.markViewPrototype.makeCopy()
    markView.lineColor = self.player.getMarkViewColor()
    self.gameboardView?.placeMarkView(markView, at: position)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
      if self.gameboardView?.markViewForPosition.count == self.batchSize {
        self.gameboardView?.clear()
        self.isCompleted = true
      }
    }
  }
}
