//
//  GameState.swift
//  XO-game
//
//  Created by Stanislav Ivanov on 02/10/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation


protocol GameState {
    
    var isCompleted: Bool { get }
    
    var inputState: GameViewInput { set get }
    
    func begin()
    
    func addMark(at position: GameboardPosition)
}
