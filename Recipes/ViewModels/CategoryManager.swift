//
//  CategoryManager.swift
//  Recipes
//
//  Created by CJ on 3/17/24.
//

import Foundation
import UIKit

@Observable
class CategoryManager {
    private let networkDataService: NetworkDataService
    private let bundleDataService: BundleDataService
    private(set) var categories: [Category] = []
    var error: Error?
    
    init(networkDataService: NetworkDataService = DataRetriever(), bundleDataService: BundleDataService = URLRetriever()) {
        self.networkDataService = networkDataService
        self.bundleDataService = bundleDataService
    }
    
    /// Fetches meal categories.
    func fetchCategories() async {
        do {
            let strURL = try bundleDataService.retrieveDownloadURL(from: Constant.Configure.resourceFile, basedOn: Constant.Configure.categoriesURLKey)
            if let url = URL(string: strURL) {
                let decodedData: Categories = try await networkDataService.fetch(from: url)
                categories = decodedData.categories
            }
        } catch {
            self.error = error
        }
    }
}
