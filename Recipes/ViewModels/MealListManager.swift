//
//  MealListManager.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import Foundation

@Observable
class MealListManager {
    private let dataRetriever: NetworkDataService
    private let urlRetriever: BundleDataService
    private(set) var mealList: [Meal] = []
    var error: Error?
    
    init(dataRetriever: NetworkDataService = RecipeDataRetriever(), urlRetriever: BundleDataService = RecipeDataURLRetriever()) {
        self.dataRetriever = dataRetriever
        self.urlRetriever = urlRetriever
    }
    
    /// Fetches meal data for a specific category.
    /// - Parameter category: The category of meals to fetch
    func fetchMeals(in category: String) async {
        do {
            let baseURL = try urlRetriever.retrieveDownloadURL(from: Constant.Configure.resourceFile, basedOn: Constant.Configure.categoryBaseURLKey)
            let mealListURL = baseURL + category
            if let url = URL(string: mealListURL) {
                let decodedData: Meals = try await dataRetriever.fetch(from: url)
                mealList = decodedData.meals
            }
        } catch {
            self.error = error
        }
    }
}
