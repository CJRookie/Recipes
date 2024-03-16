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
        let meal: String
        let mealThumb: String
        let id: String
        
        enum CodingKeys: String, CodingKey {
            case meal = "strMeal"
            case mealThumb = "strMealThumb"
            case id = "idMeal"
        }
    }
}
