//
//  RecipesApp.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import SwiftUI
import SwiftData

@main
struct RecipesApp: App {
    @State private var manager: FavoriteListManager = FavoriteListManager()
    @State private var imageRetriever = ImageRetriever()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(manager)
                .environment(imageRetriever)
        }
    }
}
