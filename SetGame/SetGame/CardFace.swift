//
//  CardFace.swift
//  SetGame
//
//  Created by macbook on 03/09/2021.
//

import SwiftUI

struct CardFace: View {
    let color: Color
    let numberOfShapes: ClosedRange<Int>
    let shape: Set.CardShape
    
    init(card: Set.Card) {
        switch card.color {
        case .red:
            color = Color.red
        case .blue:
            color = Color.blue
        case .green:
            color = Color.green
        }
        
        numberOfShapes = 1...card.numberOfShapes.rawValue
        shape = card.shape
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                ForEach(numberOfShapes, id: \.self) { shapeNumber in
                    switch shape {
                    case .diamond:
                        Diamond(width: geometry.size.width, height: geometry.size.height / CGFloat(numberOfShapes.last ?? 1))
                    case .squiggle:
                        Rectangle().aspectRatio(2, contentMode: .fit)
                    case .oval:
                        Ellipse().aspectRatio(2, contentMode: .fit)
                    }
                    
                }
                Spacer()
            }
            .foregroundColor(color)
            
        }
    }
    
}
