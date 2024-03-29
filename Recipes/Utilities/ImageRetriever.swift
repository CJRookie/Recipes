//
//  ImageRetriever.swift
//  Recipes
//
//  Created by CJ on 3/19/24.
//

import Foundation
import UIKit

protocol ImageCacheable {
    func getImage(from url: String) async -> UIImage?
    func fetchImage(from url: URL) async throws -> UIImage?
    func cacheImage(from url: URL, response: URLResponse, data: Data)
}

struct ImageRetriever: ImageCacheable {
    private var sharedURLCache: URLCache
    private var networkDataRetriever: NetworkDataService
    private let maxMemoryCacheSize: Int = 100 * 1024 * 1024
    
    init() {
        sharedURLCache = .shared
        sharedURLCache.diskCapacity = 0
        sharedURLCache.memoryCapacity = maxMemoryCacheSize
        networkDataRetriever = DataRetriever()
    }
    
    init(sharedURLCache: URLCache, networkDataRetriever: NetworkDataService) {
        self.sharedURLCache = sharedURLCache
        self.networkDataRetriever = networkDataRetriever
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
