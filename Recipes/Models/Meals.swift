//
//  Meals.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import Foundation

struct Meals: Codable {
    let meals: [Meal]
}

struct Meal: Codable, Identifiable, Hashable {
    let name: String
    let thumb: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case thumb = "strMealThumb"
        case id = "idMeal"
    }
}
