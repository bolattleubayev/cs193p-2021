//
//  Theme.swift
//  Memorize
//
//  Created by macbook on 01/09/2021.
//

import Foundation

struct Theme: Identifiable, Codable, Hashable {
    var name: String
    var emojis: [String]
    var numberOfPairs: Int
    var color: String
    var id: Int
    
    init(name: String, emojis: [String], color: String, id: Int) {
        self.name = name
        self.emojis = Array(Set(emojis)).shuffled()
        self.numberOfPairs = self.emojis.count
        self.color = color
        self.id = id
    }
}
