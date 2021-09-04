//
//  SetGame.swift
//  SetGame
//
//  Created by macbook on 03/09/2021.
//

import SwiftUI

class SetGame: ObservableObject {
    typealias Card = Set.Card
    
    init() {
        model = SetGame.createMemoryGame()
    }
    
    private static func createMemoryGame() -> Set {
        return Set()
    }
    
    @Published private var model: Set
    
    var cards: Array<Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
