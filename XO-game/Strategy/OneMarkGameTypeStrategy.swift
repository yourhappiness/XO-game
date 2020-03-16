//
//  OneMarkGameTypeStrategy.swift
//  XO-game
//
//  Created by Anastasia Romanova on 13/10/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

class OneMarkGameTypeStrategy: GameTypeStrategy {
  
  func switchToFirstState(viewController: GameViewController, player: Player) {
    viewController.swithToPlayerInputState(with: player)
  }
  
  func switchToNextState(viewController: GameViewController) {
    
    if false == viewController.currentState.isCompleted { return }
    
    if let winner = viewController.referee.determineWinner() {
      self.switchToFinishedState(with: winner, viewController: viewController)
      
    } else if viewController.gameboard.areAllPositionsFullfilled() {
      self.switchToFinishedState(with: nil, viewController: viewController)
      
    } else {
      viewController.currentPlayer = viewController.currentPlayer.next
      viewController.swithToPlayerInputState(with: viewController.currentPlayer)
    }
    
  }
  
  func switchToFinishedState(with winner: Player?, viewController: GameViewController) {
    viewController.currentState = GameFinishedState(winner: winner, inputState: viewController)
  }
  
}
