//
//  ContentView.swift
//  Memorize
//
//  Created by macbook on 10/07/2021.
//

import SwiftUI 

struct ContentView: View {
    @State var emojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻", "🚝"]
    @State var emojiCount = 8
    
    func widthThatBestFits(cardCount: Int) -> CGFloat {
        let totalArea = 470.0 * 315.0
        
        return CGFloat(sqrt((totalArea / Double(cardCount)) / 2.5))
    }
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.title)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatBestFits(cardCount: emojiCount)))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                vehicles
                animals
                people
            }
            .font(.largeTitle)
        }
        .padding(.horizontal)
        
    }
    
    var vehicles: some View {
        Button {
            emojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻", "🚝"].shuffled()
            emojiCount = Int.random(in: 4..<emojis.count)
        } label: {
            VStack {
                Image(systemName: "car")
                Text("Vehicles")
                    .font(.footnote)
                    .padding(.horizontal)
            }
            
        }
    }
    
    var animals: some View {
        Button {
            emojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🐔", "🐧", "🐦", "🐤", "🐥", "🦄", "🐴", "🐺"].shuffled()
            emojiCount = Int.random(in: 4..<emojis.count)
        } label: {
            VStack {
                Image(systemName: "hare")
                Text("Animals")
                    .font(.footnote)
                    .padding(.horizontal)
            }
        }
    }
    
    var people: some View {
        Button {
            emojis = ["😁", "😂", "😅", "😍", "👨🏻‍⚕️", "👩🏻‍🎤", "👨🏻‍🎓", "🧚🏻‍♀️", "🧛🏻‍♂️", "🧞‍♀️", "🧜🏻‍♀️", "👨🏻‍🚀", "👨🏻‍🚒", "👰🏻‍♀️", "😡", "🥶", "😱", "🤥", "😇", "😜", "😎", "🙄", "🤢", "🤠"].shuffled()
            emojiCount = Int.random(in: 4..<emojis.count)
        } label: {
            VStack {
                Image(systemName: "person")
                Text("People")
                    .font(.footnote)
                    .padding(.horizontal)
            }
            
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3.0)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture{
            isFaceUp = !isFaceUp
        }
    }
}





























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
