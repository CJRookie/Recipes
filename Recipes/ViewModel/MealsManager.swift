//
//  MealsManager.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import Foundation

@Observable
class MealsManager {
    private(set) var mealArr: [(Meals.Meal, Meal.Detail)] = []
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    /// Fetches meal data from the specified APIs, filtering out meals with null detail values
    func fetchMealData() async {
        do {
            let mealURL = try apiService.retrieveAPIAddress(from: Constant.MealsManager.resourceFile, basedOn: Constant.MealsManager.key)
            let data = try await apiService.downloadData(from: mealURL)
            let decodedData = try JSONDecoder().decode(Meals.self, from: data)
            let meals = decodedData.meals
            let baseDetailURL = try apiService.retrieveAPIAddress(from: Constant.MealDetailManager.resourceFile, basedOn: Constant.MealDetailManager.key)
            
            // fetch detail values of all meals concurrently and filter out meals with null detail value, not recommended to fetch all meal details at once when the amount of data is large.
            for meal in meals {
                let detailURL = baseDetailURL + meal.idMeal
                async let detail = fetchMealDetail(from: detailURL)
                if let detail = try? await detail {
                    mealArr.append((meal, detail))
                }
            }
        } catch {
            print("Error: \(String(describing: error))")
        }
    }
    
    /// Fetches detailed information about a meal from the specified API address.
    /// - Parameter apiAddress: The URL address of the API providing meal details
    /// - Returns: An optional `Meal.Detail` representing detailed information about the meal if successful, `nil` otherwise.
    private func fetchMealDetail(from apiAddress: String) async throws -> Meal.Detail? {
        let data = try await apiService.downloadData(from: apiAddress)
        let decodedData = try JSONDecoder().decode(Meal.self, from: data)
        if let detail = decodedData.meals.first {
            return detail
        }
        
        return nil
    }
}
