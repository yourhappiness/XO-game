//
//  HumanOpponentStrategy.swift
//  XO-game
//
//  Created by Anastasia Romanova on 05/10/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public class HumanOpponentStrategy: GameOpponentStrategy {
  func returnPlayerInputState(player: Player,
                              inputState: GameViewInput,
                              gameboard: Gameboard,
                              gameboardView: GameboardView,
                              referee: Referee) -> GameState {
    return PlayerInputState(player: player,
                            inputState: inputState,
                            gameboard: gameboard,
                            gameboardView: gameboardView)
  }
}
