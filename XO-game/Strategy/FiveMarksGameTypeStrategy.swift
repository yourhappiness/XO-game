//
//  FiveMarksGameTypeStrategy.swift
//  XO-game
//
//  Created by Anastasia Romanova on 13/10/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

class FiveMarksGameTypeStrategy: GameTypeStrategy {
  
  func switchToFirstState(viewController: GameViewController, player: Player) {
    viewController.swithToPlayerInputSeveralMarksState(with: player)
  }
  
  func switchToNextState(viewController: GameViewController) {
    
    if false == viewController.currentState.isCompleted { return }
    
    if viewController.gameboard.areAllPositionsFullfilled() || viewController.currentPlayer == .second {
      self.switchToFinishedState(viewController: viewController)
      
    } else {
      viewController.currentPlayer = viewController.currentPlayer.next
      viewController.swithToPlayerInputSeveralMarksState(with: viewController.currentPlayer)
    }
    
  }
  
  func switchToFinishedState(with winner: Player? = nil, viewController: GameViewController) {
    viewController.currentState = GameSessionExecutionState(inputState: viewController,
                                                            gameboard: viewController.gameboard)
  }
  
}
