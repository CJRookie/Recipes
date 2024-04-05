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
    private let dataRetriever: NetworkDataService
    private let urlRetriever: BundleDataService
    private(set) var categories: [Category] = []
    var error: Error?
    
    init(dataRetriever: NetworkDataService = DataRetriever(), urlRetriever: BundleDataService = URLRetriever()) {
        self.dataRetriever = dataRetriever
        self.urlRetriever = urlRetriever
    }
    
    /// Fetches meal categories.
    func fetchCategories() async {
        do {
            let strURL = try urlRetriever.retrieveDownloadURL(from: Constant.Configure.resourceFile, basedOn: Constant.Configure.categoriesURLKey)
            if let url = URL(string: strURL) {
                let decodedData: Categories = try await dataRetriever.fetch(from: url)
                categories = decodedData.categories
            }
        } catch {
            self.error = error
        }
    }
}
