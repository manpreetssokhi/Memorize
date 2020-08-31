//
//  MemoryGame.swift
//  Memorize
//
//  Created by Manpreet Sokhi on 8/30/20.
//  Copyright © 2020 Manpreet Sokhi. All rights reserved.
//

import Foundation

// Model
struct MemoryGame<CardContent> { // have to declare the "don't care"
    var cards: Array<Card>
    
    func choose(card: Card) {
        print("card chosen: \(card)")
    }
    
    // can have multiple inits, job is to initialze our vars
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>() // cards is now an empty array of cards
        for pairIndex in 0..<numberOfPairsOfCards { // 0 to not inclduding numberOfPairsOfCards
            let content = cardContentFactory(pairIndex) // type inference
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1)) // twice because it is a pair
        }
    }
    
    // fullname would be MemoryGame.Card
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent // UI independent game play so don't really care what is on the card
        var id: Int
    }
}
