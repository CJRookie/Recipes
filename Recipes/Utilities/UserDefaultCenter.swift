//
//  UserDefaultCenter.swift
//  Recipes
//
//  Created by CJ on 3/12/24.
//

import Foundation

class UserDefaultCenter {
    static let shared = UserDefaultCenter()
    private init() {}
    
    private let favoriteRecipesKey = "favoriteRecipes"
    
    func getFavoriteRecipes() -> [String] {
        UserDefaults.standard.array(forKey: favoriteRecipesKey) as? [String] ?? []
    }
    
    func updateFavoriteRecipe(recipes: [String]) {
        UserDefaults.standard.setValue(recipes, forKey: favoriteRecipesKey)
    }
}
