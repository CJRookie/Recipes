//
//  ImageCache.swift
//  Recipes
//
//  Created by CJ on 3/19/24.
//

import Foundation
import UIKit

protocol ImageDataService {
    var urlCache: URLCache { get }
    func fetchImage(from url: URL) async throws -> UIImage?
    func cacheImage(from url: URL, response: URLResponse, data: Data)
}

struct ImageCache: ImageDataService {
    private(set) var urlCache: URLCache
    private let networkDataRetriever: NetworkDataService
    
    init(urlCache: URLCache, networkDataRetriever: NetworkDataService) {
        self.urlCache = urlCache
        self.networkDataRetriever = networkDataRetriever
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
        urlCache.storeCachedResponse(cachedURLResponse, for: request)
    }
}
