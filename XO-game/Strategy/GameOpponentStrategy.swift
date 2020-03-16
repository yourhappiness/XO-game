//
//  GameOpponentStrategy.swift
//  XO-game
//
//  Created by Anastasia Romanova on 05/10/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public enum GameOpponent {
  case computer, human
  
  func getOpponentStrategy() -> GameOpponentStrategy {
    switch self {
    case .computer:
      return ComputerOpponentStrategy()
    case .human:
      return HumanOpponentStrategy()
    }
  }
}


protocol GameOpponentStrategy {
  func returnPlayerInputState(player: Player,
                              inputState: GameViewInput,
                              gameboard: Gameboard,
                              gameboardView: GameboardView,
                              referee: Referee) -> GameState
}
