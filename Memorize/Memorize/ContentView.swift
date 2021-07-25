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
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.title)
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
            .foregroundColor(.red)
            Spacer()
//            HStack {
//                vehicles
//                animals
//                people
//            }
//            .font(.largeTitle)
        }
        .padding(.horizontal)
        
    }
    
//    var vehicles: some View {
//        Button {
//            emojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻", "🚝"].shuffled()
//            emojiCount = Int.random(in: 4..<emojis.count)
//        } label: {
//            VStack {
//                Image(systemName: "car")
//                Text("Vehicles")
//                    .font(.footnote)
//                    .padding(.horizontal)
//            }
//
//        }
//    }
//
//    var animals: some View {
//        Button {
//            emojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🐔", "🐧", "🐦", "🐤", "🐥", "🦄", "🐴", "🐺"].shuffled()
//            emojiCount = Int.random(in: 4..<emojis.count)
//        } label: {
//            VStack {
//                Image(systemName: "hare")
//                Text("Animals")
//                    .font(.footnote)
//                    .padding(.horizontal)
//            }
//        }
//    }
//
//    var people: some View {
//        Button {
//            emojis = ["😁", "😂", "😅", "😍", "👨🏻‍⚕️", "👩🏻‍🎤", "👨🏻‍🎓", "🧚🏻‍♀️", "🧛🏻‍♂️", "🧞‍♀️", "🧜🏻‍♀️", "👨🏻‍🚀", "👨🏻‍🚒", "👰🏻‍♀️", "😡", "🥶", "😱", "🤥", "😇", "😜", "😎", "🙄", "🤢", "🤠"].shuffled()
//            emojiCount = Int.random(in: 4..<emojis.count)
//        } label: {
//            VStack {
//                Image(systemName: "person")
//                Text("People")
//                    .font(.footnote)
//                    .padding(.horizontal)
//            }
//
//        }
//    }
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
            ContentView(viewModel: game)
                .preferredColorScheme(.dark)
            ContentView(viewModel: game)
                .preferredColorScheme(.light)
        }
    }
}
