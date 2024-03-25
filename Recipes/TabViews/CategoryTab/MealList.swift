//
//  MealList.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import SwiftUI

struct MealList: View {
    @Environment(FavoriteListManager.self) private var favoriteListManager
    @State private var manager = MealListManager()
    @State private var text: String = ""
    let category: String
    
    var currentList: [Meal] {
        MealListOperation.filter(manager.mealList, by: text)
    }
    
    var body: some View {
        List(currentList) { meal in
            ZStack {
                MealRow(meal: meal)
                NavigationLink(value: meal) {
                    EmptyView()
                }
                .opacity(0)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationTitle(category)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Meal.self) { meal in
            MealDetail(meal: meal, favorites: favoriteListManager.favoriteRecipes)
        }
        .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by name")
        .task {
            await manager.fetchMeals(in: category)
        }
    }
}
