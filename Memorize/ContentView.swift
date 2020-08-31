//
//  ContentView.swift
//  Memorize
//
//  Created by Manpreet Sokhi on 8/28/20.
//  Copyright © 2020 Manpreet Sokhi. All rights reserved.
//

import SwiftUI

struct ContentView: View { // is created in SceneDelegate
    var viewModel: EmojiMemoryGame // since it is a class, it is a pointer to it
    
    var body: some View {
        HStack {
            // get this card from ViewModel
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }
        }
            .padding()
            .foregroundColor(Color.orange)
            .font(Font.largeTitle)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
}

// provides connection between code and what is previewed in real time
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
