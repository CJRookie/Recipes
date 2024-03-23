//
//  RecipesApp.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import SwiftUI

@main
struct RecipesApp: App {
    @State private var categoryManager = CategoryManager()
    @State private var imageCache = ImageCacheCenter()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(categoryManager)
                .environment(imageCache)
        }
    }
}
