//
//  ImageCache.swift
//  Recipes
//
//  Created by CJ on 3/19/24.
//

import Foundation
import UIKit

struct ImageCache {
    private let sharedURLCache: URLCache
    private let networkDataRetriever: NetworkDataService
    private let maxMemoryCacheSize: Int = 100 * 1024 * 1024
    
    init(sharedURLCache: URLCache = .shared, networkDataRetriever: NetworkDataService = RecipeDataRetriever()) {
        self.sharedURLCache = sharedURLCache
        self.networkDataRetriever = networkDataRetriever
        sharedURLCache.diskCapacity = 0
        sharedURLCache.memoryCapacity = maxMemoryCacheSize
    }
    
    /// Retrieves a meal image from the specified URL.
    /// - Parameter url: The URL from which to retrieve/fetch the meal image.
    /// - Returns: A `UIImage` representing the fetched meal image, or `nil` if the image is not available.
    func getRecipeImage(from url: URL) async throws -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedData = sharedURLCache.cachedResponse(for: request)?.data, let image = UIImage(data: cachedData) {
            return image
        } else {
            return try await fetchRecipeImage(from: url)
        }
    }
    
    /// Fetches a meal image from the specified URL.
    /// - Parameter url: The URL from which to fetch the meal image.
    /// - Returns: A `UIImage` representing the fetched meal image, or `nil` if the image is not available.
    private func fetchRecipeImage(from url: URL) async throws -> UIImage? {
        let downloadedData = try await networkDataRetriever.downloadData(from: url.absoluteString)
        let image = UIImage(data: downloadedData.0)
        cacheRecipeImage(from: url, response: downloadedData.1, data: downloadedData.0)
        return image
    }
    
    /// Caches a meal image for future use.
    /// - Parameters:
    ///   - url: The URL from which the meal image was fetched.
    ///   - response: The URLResponse received during the image fetching process.
    ///   - data: The data representing the fetched meal image.
    private func cacheRecipeImage(from url: URL, response: URLResponse, data: Data) {
        let request = URLRequest(url: url)
        let cachedURLResponse = CachedURLResponse(response: response, data: data, storagePolicy: .allowedInMemoryOnly)
        sharedURLCache.storeCachedResponse(cachedURLResponse, for: request)
    }
}
