//
//  ImageCenter.swift
//  Recipes
//
//  Created by CJ on 4/5/24.
//

import Foundation
import UIKit

class ImageCenter {
    private let imageRetriever: ImageDataService
    private(set) var error: Error?
    
    init(imageRetriever: ImageDataService = ImageCache(urlCache: .shared, networkDataRetriever: DataRetriever())) {
        self.imageRetriever = imageRetriever
    }
    
    /// Retrieves a meal image from the specified URL.
    /// - Parameter url: The URL from which to retrieve/fetch the meal image.
    /// - Returns: A `UIImage` representing the fetched meal image, or `nil` if the image is not available.
    func getImage(from url: String) async -> UIImage? {
        guard let url = URL(string: url) else { return nil }
        let request = URLRequest(url: url)
        if let cachedData = imageRetriever.urlCache.cachedResponse(for: request)?.data, let image = UIImage(data: cachedData) {
            return image
        } else {
            do {
                return try await imageRetriever.fetchImage(from: url)
            } catch {
                self.error = error
                return nil
            }
        }
    }
}
