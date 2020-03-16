//
//  PlaceMarkCommand.swift
//  XO-game
//
//  Created by Stanislav Ivanov on 02/10/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation


// MARK: - Command

class PlaceMarkCommand {
  
  public let player: Player
  private let position: GameboardPosition
  private let gameboardView: GameboardView
  
  init(player: Player, position: GameboardPosition, gameboardView: GameboardView) {
    self.player = player
    self.position = position
    self.gameboardView = gameboardView
  }
  
  func execute(gameboard: Gameboard) {
      if gameboard.containsAnyPlayer(at: self.position) {
        gameboard.clearPosition(self.position)
        self.gameboardView.removeMarkView(at: self.position)
      }
      gameboard.setPlayer(self.player, at: self.position)
      let markView = self.player.markViewPrototype.makeCopy()
      markView.lineColor = self.player.getMarkViewColor()
      self.gameboardView.placeMarkView(markView, at: self.position)
  }
}
