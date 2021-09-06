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
        model.getCardsInGame()
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func dealThreeMore() {
        model.dealThreeMore()
    }
    
    func newGame() {
        model = SetGame.createMemoryGame()
    }
}
