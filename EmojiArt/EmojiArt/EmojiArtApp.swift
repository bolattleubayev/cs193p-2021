//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by macbook on 10/09/2021.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    let document = EmojiArtDocument()
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: document)
        }
    }
}
