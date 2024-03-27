//
//  RecipeDataRetriever.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import Foundation

protocol NetworkDataService {
    var urlSession: URLSession { get }
    
    func downloadData(from url: URL) async throws -> (Data, URLResponse)
    func fetch<T>(from url: URL) async throws -> T where T: Decodable
}

struct RecipeDataRetriever: NetworkDataService {
    var urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    /// Downloads data from a specified URL asynchronously.
    /// - Parameter url: The URL from which to download the data.
    /// - Returns: The downloaded data.
    /// - Throws:
    ///   - `NetworkDataServiceError.invalidHTTPResponse`: If the HTTP response status code is outside the range of 200 to 299.
    func downloadData(from url: URL) async throws -> (Data, URLResponse) {
        let (data, response) = try await urlSession.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkDataServiceError.invalidHTTPResponse
        }
        
        return (data, response)
    }

    /// Fetches data from the specified URL and decodes it into the specified type.
    /// - Parameter url: The URL from which to fetch the data.
    /// - Returns: An instance of the specified type, decoded from the fetched data.
    /// - Throws: An error if the data cannot be downloaded or decoded.
    func fetch<T>(from url: URL) async throws -> T where T: Decodable {
        let result = try await downloadData(from: url)
        let decodedData = try JSONDecoder().decode(T.self, from: result.0)
        return decodedData
    }
}
