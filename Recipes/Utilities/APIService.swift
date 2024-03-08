//
//  APIService.swift
//  Recipes
//
//  Created by CJ on 3/4/24.
//

import Foundation

class APIService {
    
    /// Downloads data from a specified URL asynchronously.
    /// - Parameter url: The URL from which to download the data.
    /// - Returns: The downloaded data.
    /// - Throws:
    ///   - `APIServiceError.invalidURL`: If the provided URL is invalid or cannot be converted.
    ///   - `APIServiceError.invalidHTTPResponse`: If the HTTP response status code is outside the range of 200 to 299.
    func downloadData(from url: String) async throws -> (Data, URLResponse) {
        guard let url = URL(string: url) else { throw APIServiceError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw APIServiceError.invalidHTTPResponse
        }
        
        return (data, response)
    }
    
    /// Retrieves the API address from a specified property list (plist) file based on a provided key.
    /// - Parameters:
    ///   - resourceFile: The name of the plist file containing configuration data
    ///   - key: The key used to look up the API address within the plist file.
    /// - Returns: The API address associated with the provided key in the specified plist file.
    /// - Throws:
    ///   - `ConfigurationError.missingFile`: If the specified plist file cannot be found in the main bundle.
    ///   - `ConfigurationError.invalidFormat`: If the content of the plist file cannot be parsed as a dictionary.
    ///   - `ConfigurationError.missingApiAddress`: If the specified key is not found in the plist file.
    func retrieveAPIAddress(from resourceFile: String, basedOn key: String) throws -> String {
        guard let path = Bundle.main.path(forResource: resourceFile, ofType: "plist") else {
            throw ConfigurationError.missingFile
        }
        
        guard let config = NSDictionary(contentsOf: URL(filePath: path)) as? [String: String] else {
            throw ConfigurationError.invalidFormat(path)
        }
        
        guard let apiAddress = config[key] else {
            throw ConfigurationError.missingApiAddress
        }
        
        return apiAddress
    }
}
