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
    
    var currentList: [Meals.Meal] {
        switch selectedCategory {
        case .dessert:
            manager.meals
        case .lunch:
            []
        }
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
                MealDetail(meal)
            }
        }
        .task {
            await manager.fetchMealData()
        }
    }
}
