//
//  MealDetailManager.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import Foundation

/*
 If it is allowed to display the meals with null detail value in the Dessert category list and let users know that detail for 
 the currently selected meal is not available by displaying a custom view with an appropriate message, then this class will be 
 used to manage detail value for each meal, and the 'fetchMealDetail' func will be called when a user selects a meal.
 */
@Observable
class MealDetailManager {
    private let mealID: String
    private(set) var mealDetail: Meal.Detail?
    private let apiService: APIService
    
    init(_ mealID: String, apiService: APIService) {
        self.mealID = mealID
        self.apiService = apiService
    }
    
    func fetchMealDetail() async {
        do {
            let baseURL = try apiService.retrieveAPIAddress(from: Constant.MealDetailManager.resourceFile, basedOn: Constant.MealDetailManager.key)
            let apiURL = baseURL + mealID
            let data = try await apiService.downloadData(from: apiURL)
            let decodedData = try JSONDecoder().decode(Meal.self, from: data)
            if let detail = decodedData.meals.first {
                mealDetail = detail
            }
        } catch {
            print("Error: \(String(describing: error))")
        }
    }
}
