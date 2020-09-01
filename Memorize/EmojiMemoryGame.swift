//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Manpreet Sokhi on 8/30/20.
//  Copyright © 2020 Manpreet Sokhi. All rights reserved.
//

import SwiftUI


// ViewModel
class EmojiMemoryGame: ObservableObject {
    // Private means it can only be accessed to EmojiMemoryGame
    // Inline the func createCardContent (called a closure) - take everything except name and keyword func, paste where function would have been called, replace first curly brace with 'in' and bring curly brace where name of function would have been. Can go ahead and take out the types (if possible) because of type inference.
    // Now it is a function of the type not an instance of EmojiMemoryGame
    // @Published is a property wrapper that adds functionality around property - everytime this property (aka model) changes, it will call objectWillChange.send()
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    // Static makes it a function on the type. Instead of a function where we send an instnace of EmojiMemoryGame, we are sending it to type
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🎃", "🕷"]// constant array
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
     // var objectWillChange: ObservableObjectPublisher // doesn't need to be here, just get it for free
    
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
