//
//  ImageCenter.swift
//  Recipes
//
//  Created by CJ on 4/5/24.
//

import Foundation
import UIKit

@Observable
class ImageCenter {
    private let imageCache: ImageDataService
    private let urlRetriever: BundleDataService
    private(set) var error: Error?
    
    init(imageCache: ImageDataService = ImageCache(urlCache: .shared, networkDataRetriever: DataRetriever()), urlRetriever: BundleDataService = URLRetriever()) {
        self.imageCache = imageCache
        self.urlRetriever = urlRetriever
    }
    
    /// Retrieves a meal image from the specified URL.
    /// - Parameter url: The URL from which to retrieve/fetch the meal image.
    /// - Returns: A `UIImage` representing the fetched meal image, or `nil` if the image is not available.
    func getImage(from url: String) async -> UIImage? {
        guard let url = URL(string: url) else { return nil }
        let request = URLRequest(url: url)
        if let cachedData = imageCache.urlCache.cachedResponse(for: request)?.data, let image = UIImage(data: cachedData) {
            return image
        } else {
            do {
                return try await imageCache.fetchImage(from: url)
            } catch {
                self.error = error
                return nil
            }
        }
    }
    
    /// Fetches an image of the specified ingredient.
    /// - Parameter ingredient: The name of the ingredient to fetch the image for.
    /// - Returns: An optional `UIImage` object representing the image of the ingredient, or `nil` if the image cannot be fetched.
    func getImage(for ingredient: String) async -> UIImage? {
        do {
            let baseURL = try urlRetriever.retrieveDownloadURL(from: Constant.Configure.resourceFile, basedOn: Constant.Configure.ingredientImageBaseURLKey)
            let ingredientURL = baseURL + ingredient + "-Small.png"
            return await getImage(from: ingredientURL)
        } catch {
            return nil
        }
    }
}
