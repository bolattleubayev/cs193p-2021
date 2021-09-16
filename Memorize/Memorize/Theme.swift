//
//  Theme.swift
//  Memorize
//
//  Created by macbook on 01/09/2021.
//

import Foundation

struct Theme: Identifiable, Codable, Hashable, Equatable {
    var name: String
    var emojis: [String]
    var numberOfPairs: Int
    var color: RGBAColor
    var id: Int
    
    init(name: String, emojis: [String], color: RGBAColor, id: Int) {
        self.name = name
        self.emojis = Array(Set(emojis)).shuffled()
        self.numberOfPairs = self.emojis.count
        self.color = color
        self.id = id
    }
}

struct RGBAColor: Codable, Equatable, Hashable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
}
