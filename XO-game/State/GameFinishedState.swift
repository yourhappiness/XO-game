//
//  GameFinishedState.swift
//  XO-game
//
//  Created by Stanislav Ivanov on 02/10/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation


class GameFinishedState: GameState {
    
    var isCompleted: Bool = false
    
    let winner: Player?
    
    var inputState: GameViewInput
    
    init(winner: Player?, inputState: GameViewInput) {
        self.winner = winner
        
        self.inputState = inputState
    }
    
    func begin() {
        self.inputState.firstPlayerTurnLabel(hide: true)
        self.inputState.secondPlayerTurnLabel(hide: true)
        
        self.inputState.winnerLabel(hide: false)
        
        
        var text = "No winner"
        if let winner = self.winner {
          switch self.inputState.opponent {
          case .human:
            text = winner.winnerText()
          case .computer:
            switch winner {
            case .first:
              text = winner.winnerText()
            case .second:
              text = "Computer wins"
            }
          }
        }
        self.inputState.winnerLabel(text: text)
    }
    
    func addMark(at position: GameboardPosition) {}
}
