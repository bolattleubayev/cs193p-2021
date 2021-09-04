//
//  CardFace.swift
//  SetGame
//
//  Created by macbook on 03/09/2021.
//

import SwiftUI

struct CardFace: View {
    let card: Set.Card
    let color: Color
    let numberOfShapes: Int
    
    init(card: Set.Card) {
        self.card = card
        
        switch card.color {
        case .red:
            color = Color.red
        case .blue:
            color = Color.blue
        case .green:
            color = Color.green
        }
        
        numberOfShapes = card.numberOfShapes.rawValue
        
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                
                switch card.numberOfShapes {
                case .one:
                    Text("*")
                case .two:
                    Text("**")
                case .three:
                    Text("***")
                }
            }.foregroundColor(color)
        }
    }
    
}
