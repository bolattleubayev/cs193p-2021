//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by macbook on 10/07/2021.
//

import SwiftUI 

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text(game.randomTheme.name)
                .font(.title)
            
            Text("score: \(game.score)")
                .font(.headline)
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
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
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                        .padding(5).opacity(0.5)
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
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}





























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
    }
}
