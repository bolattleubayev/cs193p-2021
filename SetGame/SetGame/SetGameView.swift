//
//  SetGameView.swift
//  SetGame
//
//  Created by macbook on 03/09/2021.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGame
    
    var body: some View {
        VStack {
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }.foregroundColor(.blue)
            }
            Button {
                game.dealThreeMore()
            } label: {
                Text("Deal 3 more cards").font(.title)
            }.disabled(game.cardsInGame >= 81)
            Button {
                game.newGame()
            } label: {
                Text("New game").font(.title)
            }
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: SetGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.inGame {
                    if !card.isSelected {
                        shape.fill().foregroundColor(.white)
                        shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    } else {
                        shape.fill().foregroundColor(.gray)
                        shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    }
                    
                    if card.isSet {
                        shape.fill().foregroundColor(.orange)
                        shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    }
                    
                    if card.notSet {
                        shape.fill().foregroundColor(.yellow)
                        shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    }
                    
                    switch card.shape {
                    case .diamond:
                        CardFace<Diamond>(card: card)
                    case .squiggle:
                        CardFace<Rectangle>(card: card)
                    case .oval:
                        CardFace<Ellipse>(card: card)
                    }
                    
                } else if card.isSet {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(game: SetGame())
    }
}
