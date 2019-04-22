//
//  Concentration.swift
//  ConcentrationApp
//
//  Created by ChihYu Yeh on 2019/2/25.
//  Copyright © 2019 cyyeh. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    private let emojiChoices = [
        "face": ["😀", "😱", "🤣", "😍", "🥰", "😗", "😎", "😜", "😏"],
        "sport": ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🏐", "🏉", "🏓", "🎱"],
        "animal": ["🐶", "🐱", "🦁", "🙈", "🐔", "🐷", "🐧", "🦉", "🦄"],
        "weather": ["🌛", "🌜", "🌕", "⚡️", "🌙", "⛈", "🌤", "❄️", "🌈"],
        "fruit": ["🍏", "🍎", "🍊", "🍇", "🥥", "🥑", "🥝", "🍓", "🍑"],
        "car": ["🚗", "🚕", "🚌", "🚒", "🚓", "🚚", "🏎", "🚲", "🚜"]
    ]
    private var emoji = [Card: String]()
    private var theme: [String]
    private(set) var score = 0
    private(set) var flipCount = 0
    private var mismatchedCardIndexSet = Set<Int>()
    private var cardMatchedCount = 0
    private(set) var gameIsFinished = false
    
    mutating func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    cardMatchedCount += 2
                    score += 2
                    if cardMatchedCount == cards.count {
                        gameIsFinished = true
                    }
                } else {
                    if mismatchedCardIndexSet.contains(matchIndex) {
                        if score > 0 {
                            score -= 1
                        }
                    } else {
                        mismatchedCardIndexSet.insert(matchIndex)
                    }
                    if mismatchedCardIndexSet.contains(index) {
                        if score > 0 {
                            score -= 1
                        }
                    } else {
                        mismatchedCardIndexSet.insert(index)
                    }
                }
                cards[index].isFaceUp = true
            } else {
                // either no card or two cards face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    mutating func emoji(for card: Card) -> String {
        if emoji[card] == nil, theme.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(theme.count - 1)))
            emoji[card] = theme.remove(at: randomIndex)
        }
        return emoji[card] ?? "?"
    }
    
    mutating func resetGameStates() {
        emoji = [Card: String]()
        score = 0
        flipCount = 0
        theme = emojiChoices[emojiChoices.randomElement()!.key]!
        gameIsFinished = false
        cardMatchedCount = 0
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        theme = emojiChoices[emojiChoices.randomElement()!.key]!
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card] // two cards share with the same identifier
        }
        cards = cards.shuffled() // make cards be randomized initially
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
