//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Manpreet Sokhi on 8/28/20.
//  Copyright © 2020 Manpreet Sokhi. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View { // is created in SceneDelegate
    // @ObservedObject is a property wrapper that says the var viewModel has an ObservableObject in it called EmojiMemoryGame and everytime it says objectWillChange.send() redraw the UI. Any Views inside will also get re-drawn. Basically reacting to objectWillChange.send()
    @ObservedObject var viewModel: EmojiMemoryGame // since it is a class, it is a pointer to it
    
    // body is called by the system, we implement the View
    var body: some View {
        // get this card from ViewModel
        Grid(viewModel.cards) { card in // last argument to Grid
            CardView(card: card).onTapGesture {
                self.viewModel.choose(card: card)
            }
        .padding(5)
        }
            .padding()
            .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader{ geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder // now this is intepreted as a list of Views
    func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            return ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                    .padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
            // .modifier(Cardify(isFaceUp: card.isFaceUp))
                .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    // MARK: - Drawing Constants
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
    
}

// provides connection between code and what is previewed in real time
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
