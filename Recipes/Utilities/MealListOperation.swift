//
//  MealListOperation.swift
//  Recipes
//
//  Created by CJ on 3/12/24.
//

import Foundation

struct MealListOperation {
    
    func filter(_ mealList: [Meals.Meal], by category: CategoryItem, with favorites: [String]) -> [Meals.Meal] {
        switch category {
        case .favorite:
            return mealList.filter { favorites.contains($0.meal) }
        case .dessert:
            return mealList
        }
    }
    
    func filter(_ mealList: [Meals.Meal], by searchText: String) -> [Meals.Meal] {
        guard !searchText.isEmpty else { return mealList }
        let lowercasedText = searchText.lowercased()
        return mealList.filter { $0.meal.lowercased().contains(lowercasedText) }
    }
}
