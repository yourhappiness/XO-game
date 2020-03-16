//
//  PlayerInputState.swift
//  XO-game
//
//  Created by Stanislav Ivanov on 02/10/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation


class PlayerInputState: GameState {
    
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
        
        if true == self.gameboard?.containsAnyPlayer(at: position) { return }
        
        self.gameboard?.setPlayer(self.player, at: position)
        
        let markView = self.player.markViewPrototype.makeCopy()
        markView.lineColor = self.player.getMarkViewColor()
        self.gameboardView?.placeMarkView(markView, at: position)
        
        self.isCompleted = true
    }
}
