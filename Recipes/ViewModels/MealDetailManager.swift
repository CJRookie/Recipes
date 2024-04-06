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
    private let networkDataService: NetworkDataService
    private let bundleDataService: BundleDataService
    private(set) var detail: (Detail?, Error?)
    var error: Error?
    
    init(networkDataService: NetworkDataService = DataRetriever(), bundleDataService: BundleDataService = URLRetriever()) {
        self.networkDataService = networkDataService
        self.bundleDataService = bundleDataService
    }
    
    /// Fetches detailed information for a specific meal.
    /// - Parameter meal: A meal for which to fetch detailed information.
    func fetchDetail(for meal: String) async {
        do {
            let baseURL = try bundleDataService.retrieveDownloadURL(from: Constant.Configure.resourceFile, basedOn: Constant.Configure.detailBaseURLkey)
            let detailURL = baseURL + meal
            if let url = URL(string: detailURL) {
                let decodedData: MealDetails = try await networkDataService.fetch(from: url)
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
