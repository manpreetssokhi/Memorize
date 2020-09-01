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
    
    // all functions that modify self in struct (not class) need mutating
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        let chosenIndex: Int = self.index(of: card)
        self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp // flip card over directly inside array
    }
    
    // of is external name and card is internal name
    func index(of card: Card) -> Int {
        for index in 0..<self.cards.count {
            if self.cards[index].id == card.id {
                return index
            }
        }
        return 0 // TODO: bogus!
    }
    
    // can have multiple inits, job is to initialze our vars, all inits are mutating implicitly
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
