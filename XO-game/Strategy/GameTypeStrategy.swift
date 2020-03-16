//
//  GameTypeStrategy.swift
//  XO-game
//
//  Created by Anastasia Romanova on 13/10/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

public enum GameType {
  case oneMark, fiveMarks
  
  func getGameTypeStrategy() -> GameTypeStrategy {
    switch self {
    case .oneMark:
      return OneMarkGameTypeStrategy()
    case .fiveMarks:
      return FiveMarksGameTypeStrategy()
    }
  }
}

protocol GameTypeStrategy {
  func switchToFirstState(viewController: GameViewController, player: Player)
  
  func switchToNextState(viewController: GameViewController)
  
  func switchToFinishedState(with winner: Player?, viewController: GameViewController)
}
