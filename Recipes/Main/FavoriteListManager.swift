//
//  FavoriteListManager.swift
//  Recipes
//
//  Created by CJ on 3/23/24.
//

import Foundation

//@Observable
//class FavoriteListManager {
//    private(set) var favoriteRecipes: [String] = []
//    
//    func getFavoriteRecipes() {
//        favoriteRecipes = UserDefaultCenter.shared.getFavoriteRecipes()
//    }
//   
//    func updateFavoriteRecipes(isAdded: Bool, with recipe: String) {
//        if isAdded {
//            favoriteRecipes.append(recipe)
//            UserDefaultCenter.shared.updateFavoriteRecipe(recipes: favoriteRecipes)
//        } else {
//            favoriteRecipes.removeAll { $0 == recipe }
//            UserDefaultCenter.shared.updateFavoriteRecipe(recipes: favoriteRecipes)
//        }
//        getFavoriteRecipes()
//    }
//}
