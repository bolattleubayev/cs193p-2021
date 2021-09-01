//
//  ContentView.swift
//  Memorize
//
//  Created by macbook on 10/07/2021.
//

import SwiftUI 

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
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
            Text(viewModel.randomTheme.name)
                .font(.title)
            
            Text("score: \(viewModel.score)")
                .font(.headline)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatBestFits(cardCount: viewModel.cards.count)))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(convertStringToColor(word: viewModel.randomTheme.color))
            Spacer()
            Button {
                viewModel.newGame()
            } label: {
                Text("New game").font(.title)
            }
        }
        .padding(.horizontal)
        
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3.0)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}





























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        Group {
//            ContentView(viewModel: game)
//                .preferredColorScheme(.dark)
            ContentView(viewModel: game)
                .preferredColorScheme(.light)
        }
    }
}
