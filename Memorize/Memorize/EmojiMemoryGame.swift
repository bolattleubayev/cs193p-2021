//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by macbook on 25/07/2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private(set) var randomTheme: Theme
    
    private static let themes = [
        Theme(name: "vehicles",
              emojis: ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻", "🚝"],
              numberOfPairs: 4, color: "red"),
        Theme(name: "animals",
              emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🐔", "🐧", "🐦", "🐤", "🐥", "🦄", "🐴", "🐺"],
              numberOfPairs: 8,
              color: "blue"),
        Theme(name: "people",
              emojis: ["😁", "😂", "😅", "😍", "👨🏻‍⚕️", "👩🏻‍🎤", "👨🏻‍🎓", "🧚🏻‍♀️", "🧛🏻‍♂️", "🧞‍♀️", "🧜🏻‍♀️", "👨🏻‍🚀", "👨🏻‍🚒", "👰🏻‍♀️", "😡", "🥶", "😱", "🤥", "😇", "😜", "😎", "🙄", "🤢", "🤠"],
              numberOfPairs: 15,
              color: "orange"),
        Theme(name: "halloween",
              emojis: ["👻", "🎃", "🎃", "🕷"],
              numberOfPairs: 47,
              color: "yellow"),
        Theme(name: "fruits",
              emojis: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍇", "🍓"],
              numberOfPairs: 7,
              color: "green"),
        Theme(name: "objects",
              emojis: ["📱", "💻", "🖥", "🖨", "☎️", "📺"],
              numberOfPairs: 6,
              color: "black")
    ]
    
    init() {
        randomTheme = EmojiMemoryGame.themes[Int.random(in: 0..<EmojiMemoryGame.themes.count)]
        model = EmojiMemoryGame.createMemoryGame(randomTheme)
    }
    
    private static func createMemoryGame(_ theme: Theme) -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            theme.emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String>
    
    var cards: Array<Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        randomTheme =  EmojiMemoryGame.themes[Int.random(in: 0..<EmojiMemoryGame.themes.count)]
        model = EmojiMemoryGame.createMemoryGame(randomTheme)
    }
}
