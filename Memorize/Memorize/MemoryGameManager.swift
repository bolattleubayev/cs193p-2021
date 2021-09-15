//
//  MemoryGameManager.swift
//  Memorize
//
//  Created by macbook on 15/09/2021.
//

import SwiftUI

struct MemoryGameManager: View {
    @EnvironmentObject var store: ThemeStore
    
    // a Binding to a PresentationMode
    // which lets us dismiss() ourselves if we are isPresented
    @Environment(\.presentationMode) var presentationMode
    
    // we inject a Binding to this in the environment for the List and EditButton
    // using the \.editMode in EnvironmentValues
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    // tapping on this row in the List will navigate to a PaletteEditor
                    // (not subscripting by the Identifiable)
                    // (see the subscript added to RangeReplaceableCollection in UtilityExtensiosn)
                    NavigationLink(destination: EmojiMemoryGameView(game: EmojiMemoryGame(theme: store.themes[theme]))) {
                        VStack(alignment: .leading) {
                            Text(theme.name)
                            Text(theme.emojis.compactMap { $0 as String }.joined())
                        }
                        .gesture(editMode == .active ? tap : nil)
                    }
                    
//                    NavigationLink(destination: PaletteEditor(palette: $store.palettes[palette])) {
//                        VStack(alignment: .leading) {
//                            Text(palette.name)
//                            Text(palette.emojis)
//                        }
//                        // tapping when NOT in editMode will follow the NavigationLink
//                        // (that's why gesture is set to nil in that case)
//                        .gesture(editMode == .active ? tap : nil)
//                    }
                    
                }
                // teach the ForEach how to delete items
                // at the indices in indexSet from its array
                .onDelete { indexSet in
                    store.themes.remove(atOffsets: indexSet)
                }
                // teach the ForEach how to move items
                // at the indices in indexSet to a newOffset in its array
                .onMove { indexSet, newOffset in
                    store.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                }
            }
            .navigationTitle("Manage Palettes")
            .navigationBarTitleDisplayMode(.inline)
            // add an EditButton on the trailing side of our NavigationView
            // and a Close button on the leading side
            // notice we are adding this .toolbar to the List
            // (not to the NavigationView)
            // (NavigationView looks at the View it is currently showing for toolbar info)
            // (ditto title and titledisplaymode above)
            .toolbar {
                ToolbarItem { EditButton() }
                ToolbarItem(placement: .navigationBarLeading) {
                    if presentationMode.wrappedValue.isPresented,
                       UIDevice.current.userInterfaceIdiom != .pad {
                        Button("Close") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
            // see comment for editMode @State above
            .environment(\.editMode, $editMode)
        }
    }
    
    var tap: some Gesture {
        TapGesture().onEnded { }
    }
}

struct MemoryGameManager_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGameManager()
            .previewDevice("iPhone 11")
            .environmentObject(ThemeStore(named: "Preview"))
            .preferredColorScheme(.light)
    }
}
