//
//  MealList.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import SwiftUI

struct MealList: View {
    @Environment(MealsManager.self) private var manager
    @State private var selectedCategory: CategoryItem = .dessert
    @State private var text: String = ""
    
    var currentList: [Meals.Meal] {
        manager.updateMealList(by: selectedCategory, and: text)
    }
    
    var body: some View {
        NavigationStack {
            CategoryBar(selectedItem: $selectedCategory)
            List(currentList) { meal in
                ZStack {
                    MealRow(meal: meal)
                    // hide the default chevron symbol
                    NavigationLink(value: meal) {
                        EmptyView()
                    }
                    .opacity(0)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Category")
            .navigationDestination(for: Meals.Meal.self) { meal in
                MealDetail(meal, manager.favoriteRecipes)
            }
        }
        .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by name")
        .task {
            await manager.fetchMealData()
        }
        .onAppear {
            manager.getFavoriteRecipes()
        }
    }
}
