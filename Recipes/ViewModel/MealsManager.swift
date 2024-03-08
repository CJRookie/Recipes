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
    private let mealDataCenter: MealDataCenter
    
    init(mealDataCenter: MealDataCenter = MealDataCenter()) {
        self.mealDataCenter = mealDataCenter
    }
    
    func fetchMealData() async -> [Meals.Meal] {
        do {
            return try await mealDataCenter.fetchMealData()
        } catch {
            print("Error: \(String(describing: error))")
        }
        
        return []
    }
    
    func fetchMealDetail(_ meal: Meals.Meal) async -> Meal.Detail? {
        do {
            return try await mealDataCenter.fetchMealDetail(for: meal)
        } catch {
            print("Error: \(String(describing: error))")
        }
        
        return nil
    }
    
    func getImage(from url: String) async -> UIImage? {
        do {
            if let url = URL(string: url) {
                return try await mealDataCenter.getMealImage(from: url)
            }
        } catch {
            print("Error: \(String(describing: error))")
        }
        
        return nil
    }
}
