//
//  MemoryGame.swift
//  Memorize
//
//  Created by Manpreet Sokhi on 8/30/20.
//  Copyright © 2020 Manpreet Sokhi. All rights reserved.
//

import Foundation

// Model
struct MemoryGame<CardContent> where CardContent: Equatable { // have to declare the "don't care", only works when CardContent can be equatable
    var cards: Array<Card>
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only } // $0 for first argument $1 for second etc.
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue // newValue is a special var that only appears inside set for computed property, it is an optional
            }
        }
    }
    
    
    // all functions that modify self in struct (not class) need mutating
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched { // , is like a sequential &&
            // scenario 1 - all cards are face down and then hit card, it flips, and no matching happens
            // scenario 2 - have one card up and click on a second card - this is where matching will happen
            // scenario 3 - two cards face up and click third card - turn other two face down regardless if match and new card touched needs to flip
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true // flip card over directly inside array
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
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
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent // UI independent game play so don't really care what is on the card
        var id: Int
    }
}
