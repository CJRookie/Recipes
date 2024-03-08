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
    private(set) var meals: [Meals.Meal] = []
    private let mealDataCenter: MealDataCenter
    
    init(mealDataCenter: MealDataCenter = MealDataCenter()) {
        self.mealDataCenter = mealDataCenter
    }
    
    func fetchMealData() async {
        do {
            meals = try await mealDataCenter.fetchMealData()
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
