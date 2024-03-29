//
//  ImageRetriever.swift
//  Recipes
//
//  Created by CJ on 3/19/24.
//

import Foundation
import UIKit

protocol ImageDataService {
    func getImage(from url: String) async throws -> UIImage?
    func fetchImage(from url: URL) async throws -> UIImage?
    func cacheImage(from url: URL, response: URLResponse, data: Data)
}

@Observable
class ImageRetriever: ImageDataService {
    private var sharedURLCache: URLCache
    private var networkDataRetriever: NetworkDataService
    private var bundleDataService: BundleDataService
    private let maxMemoryCacheSize: Int = 100 * 1024 * 1024
    
    init() {
        sharedURLCache = URLCache(memoryCapacity: maxMemoryCacheSize, diskCapacity: 0)
        networkDataRetriever = DataRetriever()
        bundleDataService = URLRetriever()
    }
    
    init(sharedURLCache: URLCache, networkDataRetriever: NetworkDataService, bundleDataService: BundleDataService) {
        self.sharedURLCache = sharedURLCache
        self.networkDataRetriever = networkDataRetriever
        self.bundleDataService = bundleDataService
    }
    
    /// Retrieves a meal image from the specified URL.
    /// - Parameter url: The URL from which to retrieve/fetch the meal image.
    /// - Returns: A `UIImage` representing the fetched meal image, or `nil` if the image is not available.
    func getImage(from url: String) async -> UIImage? {
        guard let url = URL(string: url) else { return nil }
        let request = URLRequest(url: url)
        if let cachedData = sharedURLCache.cachedResponse(for: request)?.data, let image = UIImage(data: cachedData) {
            return image
        } else {
            do {
                return try await fetchImage(from: url)
            } catch {
                return nil
            }
        }
    }
    
    /// Fetches an image of the specified ingredient.
    /// - Parameter ingredient: The name of the ingredient to fetch the image for.
    /// - Returns: An optional `UIImage` object representing the image of the ingredient, or `nil` if the image cannot be fetched.
    func fetchIngredientImage(_ ingredient: String) async -> UIImage? {
        do {
            let baseURL = try bundleDataService.retrieveDownloadURL(from: Constant.Configure.resourceFile, basedOn: Constant.Configure.ingredientImageBaseURLKey)
            let ingredientURL = baseURL + ingredient + "-Small.png"
            return await getImage(from: ingredientURL)
        } catch {
            return nil
        }
    }
    
    /// Fetches a meal image from the specified URL.
    /// - Parameter url: The URL from which to fetch the meal image.
    /// - Returns: A `UIImage` representing the fetched meal image, or `nil` if the image is not available.
    func fetchImage(from url: URL) async throws -> UIImage? {
        let downloadedData = try await networkDataRetriever.downloadData(from: url)
        let image = UIImage(data: downloadedData.0)
        cacheImage(from: url, response: downloadedData.1, data: downloadedData.0)
        return image
    }
    
    /// Caches a meal image for future use.
    /// - Parameters:
    ///   - url: The URL from which the meal image was fetched.
    ///   - response: The URLResponse received during the image fetching process.
    ///   - data: The data representing the fetched meal image.
    func cacheImage(from url: URL, response: URLResponse, data: Data) {
        let request = URLRequest(url: url)
        let cachedURLResponse = CachedURLResponse(response: response, data: data, storagePolicy: .allowedInMemoryOnly)
        sharedURLCache.storeCachedResponse(cachedURLResponse, for: request)
    }
}
