//
//  MealDataCenter.swift
//  Recipes
//
//  Created by CJ on 3/5/24.
//

import Foundation
import UIKit

class MealDataCenter {
    private let apiService: APIService
    private let sharedURLCache: URLCache
    
    init(apiService: APIService = APIService(), cache: URLCache = URLCache.shared) {
        self.apiService = apiService
        self.sharedURLCache = cache
    }
    
    func fetchMealData() async throws -> [Meals.Meal] {
        let mealURL = try apiService.retrieveAPIAddress(from: Constant.MealsManager.resourceFile, basedOn: Constant.MealsManager.dessertURLKey)
        let downloadedData = try await apiService.downloadData(from: mealURL)
        let decodedData = try JSONDecoder().decode(Meals.self, from: downloadedData.0)
        return decodedData.meals
    }
    
    func fetchMealDetail(for meal: Meals.Meal) async throws -> Meal.Detail? {
        let baseURL = try apiService.retrieveAPIAddress(from: Constant.MealsManager.resourceFile, basedOn: Constant.MealsManager.detailBaseURLkey)
        let apiURL = baseURL + meal.idMeal
        let downloadedData = try await apiService.downloadData(from: apiURL)
        let decodedData = try JSONDecoder().decode(Meal.self, from: downloadedData.0)
        if let detail = decodedData.meals.first {
            return detail
        }
        
        return nil
    }

    func getMealImage(from url: URL) async throws -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedData = sharedURLCache.cachedResponse(for: request)?.data, let image = UIImage(data: cachedData) {
            return image
        } else {
            return try await fetchMealImage(from: url)
        }
    }
    
    private func fetchMealImage(from url: URL) async throws -> UIImage? {
        let downloadedData = try await apiService.downloadData(from: url.absoluteString)
        let image = UIImage(data: downloadedData.0)
        cacheMealImage(from: url, response: downloadedData.1, data: downloadedData.0)
        return image
    }
    
    private func cacheMealImage(from url: URL, response: URLResponse, data: Data) {
        let request = URLRequest(url: url)
        let cachedURLResponse = CachedURLResponse(response: response, data: data)
        sharedURLCache.storeCachedResponse(cachedURLResponse, for: request)
    }
}
