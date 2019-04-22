//
//  ViewController.swift
//  ConcentrationApp
//
//  Created by ChihYu Yeh on 2019/2/25.
//  Copyright © 2019 cyyeh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    // computed properties
    private var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBAction private func touchNewGameButton(_ sender: UIButton) {
        game.resetGameStates()
        updateViewFromModel()
    }
    @IBOutlet private weak var gameFinishedLabel: UILabel!
    @IBOutlet private weak var gameScoreLabel: UILabel!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("choosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(game.emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
        gameScoreLabel.text = "Score: \(game.score)"
        if game.gameIsFinished {
            gameFinishedLabel.textColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            gameFinishedLabel.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        } else {
            gameFinishedLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            gameFinishedLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
}

