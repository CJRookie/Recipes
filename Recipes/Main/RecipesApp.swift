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
    @State private var categoryManager = CategoryManager()
    @State private var favoriteListManager = FavoriteListManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(categoryManager)
                .environment(favoriteListManager)
        }
    }
}
