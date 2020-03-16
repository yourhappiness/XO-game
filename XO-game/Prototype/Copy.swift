//
//  Copy.swift
//  XO-game
//
//  Created by Stanislav Ivanov on 02/10/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

protocol Copying {
    init(_ prototype: Self)
}

extension Copying {
    func makeCopy() -> Self {
        return type(of: self).init(self)
    }
}



