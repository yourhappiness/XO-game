//
//  ComputerOpponentStrategy.swift
//  XO-game
//
//  Created by Anastasia Romanova on 05/10/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public class ComputerOpponentStrategy: GameOpponentStrategy {
  func returnPlayerInputState(player: Player,
                              inputState: GameViewInput,
                              gameboard: Gameboard,
                              gameboardView: GameboardView,
                              referee: Referee) -> GameState {
    return ComputerInputState(inputState: inputState, gameboard: gameboard, gameboardView: gameboardView, referee: referee)
  }
}
