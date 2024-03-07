//
//  ContentView.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(MealsManager.self) private var mealsManager
    @State private var selection: Tab = .home
    
    enum Tab: String {
        case home
        
        var title: String {
            rawValue.capitalized
        }
    }
    
    var body: some View {
        TabView(selection: $selection) {
            MealList()
                .tabItem {
                    Label(Tab.home.title, systemImage: "house")
                }
                .tag(Tab.home)
        }
        .task {
            await mealsManager.fetchMealData()
        }
    }
}
