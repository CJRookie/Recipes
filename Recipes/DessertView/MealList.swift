//
//  MealList.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import SwiftUI

struct MealList: View {
    @Environment(MealsManager.self) private var mealsManager
    @State private var selectedCategory: CategoryItem = .dessert
    
    var currentList: [(Meals.Meal, Meal.Detail)] {
        switch selectedCategory {
        case .dessert:
            mealsManager.mealArr
        case .lunch:
            []
        }
    }
    
    var body: some View {
        NavigationStack {
            CategoryBar(selectedItem: $selectedCategory)
            List(currentList, id: \.0) { meal in
                ZStack {
                    MealRow(meal: meal.0)
                    // hide the default chevron symbol
                    NavigationLink(value: meal.1) {
                        EmptyView()
                    }
                    .opacity(0)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Category")
            .navigationDestination(for: Meal.Detail.self) { detail in
                MealDetail(mealDetail: detail)
            }
        }
    }
}
