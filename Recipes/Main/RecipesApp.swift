//
//  RecipesApp.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import SwiftUI

@main
struct RecipesApp: App {
    @State private var mealsManager = MealsManager(apiService: APIService())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(mealsManager)
        }
    }
}
