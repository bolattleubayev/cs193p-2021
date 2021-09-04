//
//  Set.swift
//  SetGame
//
//  Created by macbook on 03/09/2021.
//

import Foundation

struct Set {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    init() {
        cards = []
        var id: Int = 0
        
        for numberOfShapes in CardNumberOfShapes.allCases {
            for shape in CardShape.allCases {
                for shading in CardShading.allCases {
                    for color in CardColor.allCases {
                        cards.append(Card(numberOfShapes: numberOfShapes,
                                          shape: shape,
                                          shading: shading,
                                          color: color,
                                          id: id)
                        )
                        id += 1
                    }
                }
            }
        }
        
        cards = cards.shuffled()
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isSet
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
//                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
//                    cards[chosenIndex].isSet = true
//                    cards[potentialMatchIndex].isSet = true
//                } else {
//                    cards[chosenIndex].isSeen = true
//                    cards[potentialMatchIndex].isSeen = true
//                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isSet = false
        let numberOfShapes: CardNumberOfShapes
        let shape: CardShape
        let shading: CardShading
        let color: CardColor
        let id: Int
        var isSeen = false
    }
    
    enum CardNumberOfShapes: Int, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
    }
    
    enum CardShape: CaseIterable {
        case diamond
        case squiggle
        case oval
    }
    
    enum CardShading: CaseIterable {
        case solid
        case striped
        case open
    }
    
    enum CardColor: CaseIterable {
        case red
        case green
        case blue
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
