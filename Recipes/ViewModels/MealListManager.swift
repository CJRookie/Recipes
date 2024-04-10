//
//  MealListManager.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import Foundation

@Observable
class MealListManager {
    private let networkDataService: NetworkDataService
    private let bundleDataService: BundleDataService
    private(set) var mealList: [Meal] = []
    private(set) var error: Error?
    
    init(networkDataService: NetworkDataService = DataRetriever(), bundleDataService: BundleDataService = URLRetriever()) {
        self.networkDataService = networkDataService
        self.bundleDataService = bundleDataService
    }
    
    /// Fetches meal data for a specific category.
    /// - Parameter category: The category of meals to fetch
    func fetchMeals(in category: String) async {
        do {
            let baseURL = try bundleDataService.retrieveDownloadURL(from: Constant.Configure.resourceFile, basedOn: Constant.Configure.categoryBaseURLKey)
            let mealListURL = baseURL + category
            if let url = URL(string: mealListURL) {
                let decodedData: Meals = try await networkDataService.fetch(from: url)
                mealList = decodedData.meals
            }
        } catch {
            self.error = error
        }
    }
}
