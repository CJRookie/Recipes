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
    @State private var manager = FavoriteListManager()
    @State private var imageCenter = ImageCenter()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(manager)
                .environment(imageCenter)
        }
    }
}
