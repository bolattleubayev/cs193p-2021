//
//  Theme.swift
//  Memorize
//
//  Created by macbook on 01/09/2021.
//

import Foundation

struct Theme {
    var name: String
    var emojis: [String]
    var numberOfPairs: Int
    var color: String
    
    init(name: String, emojis: [String], numberOfPairs: Int, color: String) {
        self.name = name
        self.emojis = Array(Set(emojis)).shuffled()
        self.numberOfPairs = min(numberOfPairs, self.emojis.count)
        self.color = color
    }
}
