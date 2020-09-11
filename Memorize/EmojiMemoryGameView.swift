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
        VStack {
            // get this card from ViewModel
            Grid(viewModel.cards) { card in // last argument to Grid
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75)){
                        self.viewModel.choose(card: card)
                    }
                }
            .padding(5)
            }
                .padding()
                .foregroundColor(Color.orange)
            Button(action: {
                withAnimation(.easeInOut) {
                    self.viewModel.resetGame()
                }
            }, label: { Text("New Game")}) // learn to make the Text that appears to user internationalizable so it appears in different languages - localized string key
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader{ geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder // now this is intepreted as a list of Views
    func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                            .onAppear {
                                self.startBonusTimeAnimation()
                        }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }
                .padding(5).opacity(0.4)
                .transition(.identity)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
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
