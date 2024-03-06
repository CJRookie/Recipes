//
//  Meals.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import Foundation

struct Meals: Codable {
    let meals: [Meal]
    
    struct Meal: Codable, Identifiable, Hashable {
        let strMeal: String
        let strMealThumb: String
        let idMeal: String
        
        var id: String { idMeal }
    }
}
