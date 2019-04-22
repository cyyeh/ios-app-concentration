//
//  Card.swift
//  ConcentrationApp
//
//  Created by ChihYu Yeh on 2019/2/25.
//  Copyright © 2019 cyyeh. All rights reserved.
//

import Foundation

struct Card: Hashable {  
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
