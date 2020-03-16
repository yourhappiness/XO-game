//
//  Player.swift
//  XO-game
//
//  Created by Evgeny Kireev on 26/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

public enum Player: CaseIterable {
    case first
    case second
    
    var next: Player {
        switch self {
        case .first: return .second
        case .second: return .first
        }
    }
    
    var markViewPrototype: MarkView {
        switch self {
        case .first:
            return XView()
        case .second:
            return OView()
        }
    }
  
    func getMarkViewColor() -> UIColor {
      switch self {
      case .first:
        return .red
      case .second:
        return .green
      }
    }
    
    func winnerText() -> String {
        var text = "No winner"
        switch self {
        case .first:
            text = "First player win"
        case .second:
            text = "Second player win"
        }
        return text
    }
}
