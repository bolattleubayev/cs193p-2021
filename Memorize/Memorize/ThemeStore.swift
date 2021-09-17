//
//  ThemeStore.swift
//  Memorize
//
//  Created by macbook on 15/09/2021.
//

import SwiftUI

class ThemeStore: ObservableObject {
    let name: String
    
    @Published var themes = [Theme]() {
        didSet {
            storeInUserDefaults()
        }
    }
    
    private var userDefaultsKey: String {
        "ThemeStore:" + name
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedThemes = try? JSONDecoder().decode(Array<Theme>.self, from: jsonData) {
            themes = decodedThemes
        }
    }
    
    init(named name: String) {
        self.name = name
        restoreFromUserDefaults()
        if themes.isEmpty {
            insertTheme(named: "vehicles",
                        emojis: ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻", "🚝"], color: Color(red: 255.0 / 255.0, green: 59.0 / 255.0, blue: 48.0 / 255.0))
            insertTheme(named: "animals",
                  emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🐔", "🐧", "🐦", "🐤", "🐥", "🦄", "🐴", "🐺"],
                  color: Color(red: 48.0 / 255.0, green: 176.0 / 255.0, blue: 199.0 / 255.0))
            insertTheme(named: "people",
                  emojis: ["😁", "😂", "😅", "😍", "👨🏻‍⚕️", "👩🏻‍🎤", "👨🏻‍🎓", "🧚🏻‍♀️", "🧛🏻‍♂️", "🧞‍♀️", "🧜🏻‍♀️", "👨🏻‍🚀", "👨🏻‍🚒", "👰🏻‍♀️", "😡", "🥶", "😱", "🤥", "😇", "😜", "😎", "🙄", "🤢", "🤠"],
                  color: Color(red: 255.0 / 255.0, green: 204.0 / 255.0, blue: 199.0 / 255.0))
            insertTheme(named: "halloween",
                  emojis: ["👻", "🎃", "🎃", "🕷"],
                  color: Color(red: 255.0 / 255.0, green: 149.0 / 255.0, blue: 0.0 / 255.0))
            insertTheme(named: "fruits",
                  emojis: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍇", "🍓"],
                  color: Color(red: 52.0 / 255.0, green: 199.0 / 255.0, blue: 89.0 / 255.0))
            insertTheme(named: "objects",
                  emojis: ["📱", "💻", "🖥", "🖨", "☎️", "📺"],
                  color: Color.black)
        }
    }
    
    // MARK: - Intent
    
    func theme(at index: Int) -> Theme {
        let safeIndex = min(max(index, 0), themes.count - 1)
        return themes[safeIndex]
    }
    
    @discardableResult
    func removeTheme(at index: Int) -> Int {
        if themes.count > 1, themes.indices.contains(index) {
            themes.remove(at: index)
        }
        return index % themes.count
    }
    
    func createNewTheme() -> Theme? {
        insertTheme(named: "New Theme", color: Color.gray)
        return themes.last
    }
    
    func insertTheme(named name: String, emojis: [String]? = nil, color: Color, at index: Int = 0) {
        let unique = (themes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let theme = Theme(name: name, emojis: emojis ?? [""], color: RGBAColor(color: color), id: unique)
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(theme, at: safeIndex)
    }
}
