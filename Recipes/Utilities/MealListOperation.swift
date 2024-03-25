//
//  MealListOperation.swift
//  Recipes
//
//  Created by CJ on 3/12/24.
//

import Foundation

struct MealListOperation {
    
    static func filter(_ mealList: [Meal], by searchText: String) -> [Meal] {
        guard !searchText.isEmpty else { return mealList }
        let lowercasedText = searchText.lowercased()
        return mealList.filter { $0.name.lowercased().contains(lowercasedText) }
    }
}
