//
//  SetGameView.swift
//  SetGame
//
//  Created by macbook on 03/09/2021.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGame
    
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack{
                gameBody
                HStack {
                    restart
                    Spacer()
                }
                .padding(.horizontal)
            }
            deckBody
        }
        .padding()
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards.filter({ $0.inGame }), aspectRatio: 2/3) { card in
            if !isUndealt(card) {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .onTapGesture {
                        game.choose(card)
                    }.foregroundColor(.blue)
            }
        }
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(.blue)
        .onTapGesture {
            // "deal" cards
            game.dealThreeMore()
            for card in game.cards.filter({ $0.inGame }) {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    var restart: some View {
        Button("Restart") {
            withAnimation {
                dealt = []
                game.restart()
            }
        }
    }
    
    var dealThreeMore: some View {
        Button("Deal") {
            withAnimation {
                game.dealThreeMore()
            }
        }
        .disabled(game.cardsInGame >= 81)
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: SetModel.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_  card: SetModel.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: SetModel.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: SetModel.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
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
