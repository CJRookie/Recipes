//
//  MealsManager.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import Foundation
import UIKit

@Observable
class MealsManager {
    private let mealDataProvider: MealDataProvider
    private let mealListOperation: MealListOperation
    private(set) var mealList: [Meals.Meal] = []
    private(set) var favoriteRecipes: [String] = []
    
    init(mealDataCenter: MealDataProvider = MealDataProvider(), mealListOperation: MealListOperation = MealListOperation()) {
        self.mealDataProvider = mealDataCenter
        self.mealListOperation = mealListOperation
    }
    
    func fetchMealData() async {
        do {
            mealList = try await mealDataProvider.fetchMealData()
        } catch {
            print("Error: \(String(describing: error))")
        }
    }
    
    func fetchMealDetail(for meal: Meals.Meal) async -> (Meal.Detail?, Error?) {
        do {
            let detail = try await mealDataProvider.fetchMealDetail(for: meal)
            return (detail, nil)
        } catch {
            print("Error: \(String(describing: error))")
            return (nil, error)
        }
    }
    
    func getImage(from url: String) async -> UIImage? {
        do {
            if let url = URL(string: url) {
                return try await mealDataProvider.getMealImage(from: url)
            }
        } catch {
            print("Error: \(String(describing: error))")
        }
        
        return nil
    }
    
    func updateMealList(by category: CategoryItem, and searchText: String) -> [Meals.Meal] {
        let filteredBySearchText = mealListOperation.filter(mealList, by: searchText)
        return mealListOperation.filter(filteredBySearchText, by: category, with: favoriteRecipes)
    }
    
    func getFavoriteRecipes() {
        favoriteRecipes = UserDefaultCenter.shared.getFavoriteRecipes()
    }
    
    func updateFavoriteRecipes(isAdded: Bool, with recipe: String) {
        if isAdded {
            favoriteRecipes.append(recipe)
            UserDefaultCenter.shared.updateFavoriteRecipe(recipes: favoriteRecipes)
        } else {
            favoriteRecipes.removeAll { $0 == recipe }
            UserDefaultCenter.shared.updateFavoriteRecipe(recipes: favoriteRecipes)
        }
        getFavoriteRecipes()
    }
}
