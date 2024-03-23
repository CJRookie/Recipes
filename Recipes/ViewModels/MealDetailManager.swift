//
//  MealDetailManager.swift
//  Recipes
//
//  Created by CJ on 3/5/24.
//

import Foundation
import UIKit

@Observable
class MealDetailManager {
    private(set) var detail: (Detail?, Error?)
    private let dataRetriever: NetworkDataService
    private let urlRetriever: BundleDataService
    var error: Error?
    
    init(dataRetriever: NetworkDataService = RecipeDataRetriever(), urlRetriever: BundleDataService = RecipeDataURLRetriever()) {
        self.dataRetriever = dataRetriever
        self.urlRetriever = urlRetriever
    }
    
    /// Fetches detailed information for a specific meal.
    /// - Parameter meal: The meal for which to fetch detailed information.
    func fetchMealDetail(for meal: Meal) async {
        do {
            let baseURL = try urlRetriever.retrieveDownloadURL(from: Constant.Configure.resourceFile, basedOn: Constant.Configure.detailBaseURLkey)
            let detailURL = baseURL + meal.id
            if let url = URL(string: detailURL) {
                let decodedData: MealDetails = try await dataRetriever.fetch(from: url)
                if let mealDetail = decodedData.meals.first {
                    detail = (mealDetail, nil)
                }
            }
        } catch {
            detail = (nil, error)
            self.error = error
        }
    }
}
