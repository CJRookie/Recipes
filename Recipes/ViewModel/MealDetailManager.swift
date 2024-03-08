//
//  MealDetailManager.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import Foundation
import UIKit

@Observable
class MealDetailManager {
    private(set) var meal: Meals.Meal
    private(set) var mealDetail: Meal.Detail?
    private let mealDataCenter: MealDataCenter
    
    init(_ meal: Meals.Meal, mealDataCenter: MealDataCenter = MealDataCenter()) {
        self.meal = meal
        self.mealDataCenter = mealDataCenter
    }
    
    func fetchMealDetail() async {
        do {
            mealDetail = try await mealDataCenter.fetchMealDetail(for: meal)
        } catch {
            print("Error: \(String(describing: error))")
        }
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
