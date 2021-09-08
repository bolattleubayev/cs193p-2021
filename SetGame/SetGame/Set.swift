//
//  Set.swift
//  SetGame
//
//  Created by macbook on 03/09/2021.
//

import Foundation

struct Set {
    private var cards: Array<Card>
    private var cardsInGame = 12
    
    private var indexOfTheFirstSelectedCard: Int?
    private var indexOfTheSecondSelectedCard: Int?
    
    init() {
        cards = []
        var id: Int = 0
        
        for numberOfShapes in CardNumberOfShapes.allCases {
            for shape in CardShape.allCases {
                for shading in CardShading.allCases {
                    for color in CardColor.allCases {
                        cards.append(Card(id: id,
                                          numberOfShapes: numberOfShapes,
                                          shape: shape,
                                          shading: shading,
                                          color: color)
                        )
                        id += 1
                    }
                }
            }
        }
        
        cards = cards.shuffled()
        addCardsToGame()
    }
    
    func isSet(cards: [Card]) -> Bool {
        let sum = [
            cards.reduce(0, { $0 + $1.numberOfShapes.rawValue }),
            cards.reduce(0, { $0 + $1.numberOfShapes.rawValue }),
            cards.reduce(0, { $0 + $1.numberOfShapes.rawValue }),
            cards.reduce(0, { $0 + $1.numberOfShapes.rawValue }),
        ]
        
        return sum.reduce(true, { $0 && ($1 % 3 == 0) })
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           cards[chosenIndex].inGame && !cards[chosenIndex].isSet {
            
            if let potentialMatchIndexOne = indexOfTheFirstSelectedCard, let potentialMatchIndexTwo = indexOfTheSecondSelectedCard {
                // if the third card was selected
                
                let cardsToCheck = [cards[potentialMatchIndexOne],
                                cards[potentialMatchIndexTwo],
                                cards[chosenIndex]
                ]
                
                if isSet(cards: cardsToCheck) {
                    cards[potentialMatchIndexOne].isSet = true
                    cards[potentialMatchIndexTwo].isSet = true
                    cards[chosenIndex].isSet = true
                    
                    cards[potentialMatchIndexOne].inGame = false
                    cards[potentialMatchIndexTwo].inGame = false
                    cards[chosenIndex].inGame = false
                }
                
                cards.indices.forEach({ cards[$0].isSelected = false })
                indexOfTheFirstSelectedCard = nil
                indexOfTheSecondSelectedCard = nil
                
            } else if indexOfTheFirstSelectedCard != nil && indexOfTheSecondSelectedCard == nil {
                // if one card is selected
                indexOfTheSecondSelectedCard = chosenIndex
                cards[chosenIndex].isSelected = true
            } else {
                // if no cards were selected
                indexOfTheFirstSelectedCard = chosenIndex
                cards[chosenIndex].isSelected = true
            }
            
        }
    }
    
    mutating func dealThreeMore() {
        cardsInGame += 3
        addCardsToGame()
    }
    
    mutating func addCardsToGame() {
        for index in 0..<cards.count {
            if index < cardsInGame {
                cards[index].inGame = true
            } else {
                break
            }
        }
    }
    
    func getCardsInGame() -> Array<Card> {
        cards.filter( { $0.inGame && !$0.isSet} )
    }
    
    struct Card: Identifiable {
        let id: Int
        
        var isSet = false
        var inGame = false
        var isSelected = false
        
        let numberOfShapes: CardNumberOfShapes
        let shape: CardShape
        let shading: CardShading
        let color: CardColor
        
    }
    
    enum CardNumberOfShapes: Int, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
    }
    
    enum CardShape: Int, CaseIterable {
        case diamond = 1
        case squiggle = 2
        case oval = 3
    }
    
    enum CardShading: Int, CaseIterable {
        case solid = 1
        case striped = 2
        case open = 3
    }
    
    enum CardColor: Int, CaseIterable {
        case red = 1
        case green = 2
        case blue = 3
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
