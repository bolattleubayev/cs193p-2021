//
//  MemorizeApp.swift
//  Memorize
//
//  Created by macbook on 10/07/2021.
//

import SwiftUI

@main
struct MemorizeApp: App {
//    private let game = EmojiMemoryGame()
    @StateObject var themeStore = ThemeStore(named: "Default")
    
    var body: some Scene {
        WindowGroup {
//            EmojiMemoryGameView(game: game)
            MemoryGameManager()
                .environmentObject(themeStore)
        }
    }
}
