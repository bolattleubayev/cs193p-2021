//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by macbook on 10/07/2021.
//

import SwiftUI 

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    func widthThatBestFits(cardCount: Int) -> CGFloat {
        let totalArea = 470.0 * 315.0
        
        return CGFloat(sqrt((totalArea / Double(cardCount)) / 2.5))
    }
    
    func convertStringToColor(word: String) -> Color {
        switch word {
        case "red":
            return Color.red
        case "blue":
            return Color.blue
        case "orange":
            return Color.orange
        case "yellow":
            return Color.yellow
        case "green":
            return Color.green
        case "black":
            return Color.black
        default:
            return Color.gray
        }
    }
    
    var body: some View {
        VStack {
            Text(game.randomTheme.name)
                .font(.title)
            
            Text("score: \(game.score)")
                .font(.headline)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatBestFits(cardCount: game.cards.count)))]) {
                    ForEach(game.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(convertStringToColor(word: game.randomTheme.color))
            Spacer()
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
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
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
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}





























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        Group {
//            EmojiMemoryGameView(game: game)
//                .preferredColorScheme(.dark)
            EmojiMemoryGameView(game: game)
                .preferredColorScheme(.light)
        }
    }
}
