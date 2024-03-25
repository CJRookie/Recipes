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
    private let dataRetriever: NetworkDataService
    private let urlRetriever: BundleDataService
    private(set) var detail: (Detail?, Error?)
    var error: Error?
    
    init(dataRetriever: NetworkDataService = RecipeDataRetriever(), urlRetriever: BundleDataService = RecipeDataURLRetriever()) {
        self.dataRetriever = dataRetriever
        self.urlRetriever = urlRetriever
    }
    
    /// Fetches detailed information for a specific meal.
    /// - Parameter meal: A meal for which to fetch detailed information.
    func fetchDetail(for meal: String) async {
        do {
            let baseURL = try urlRetriever.retrieveDownloadURL(from: Constant.Configure.resourceFile, basedOn: Constant.Configure.detailBaseURLkey)
            let detailURL = baseURL + meal
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
    
    /// Fetches an image of the specified ingredient.
    /// - Parameter ingredient: The name of the ingredient to fetch the image for.
    /// - Returns: An optional `UIImage` object representing the image of the ingredient, or `nil` if the image cannot be fetched.
    func fetchIngredientImage(_ ingredient: String) async -> UIImage? {
        do {
            let baseURL = try urlRetriever.retrieveDownloadURL(from: Constant.Configure.resourceFile, basedOn: Constant.Configure.ingredientImageBaseURLKey)
            let ingredientURL = baseURL + ingredient + "-Small.png"
            return await ImageCacheCenter.shared.getImage(from: ingredientURL)
        } catch {
            self.error = error
            return nil
        }
    }
}
