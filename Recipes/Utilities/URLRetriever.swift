//
//  URLRetriever.swift
//  Recipes
//
//  Created by CJ on 3/20/24.
//

import Foundation

protocol BundleDataService {
    func retrieveDownloadURL(from resourceFile: String, basedOn key: String) throws -> String
}

struct URLRetriever: BundleDataService {
    
    /// Retrieves the API address from a specified property list (plist) file based on a provided key.
    /// - Parameters:
    ///   - resourceFile: The name of the plist file containing configuration data
    ///   - key: The key used to look up the API address within the plist file.
    /// - Returns: The API address associated with the provided key in the specified plist file.
    /// - Throws:
    ///   - `BundleDataServiceError.missingFile`: If the specified plist file cannot be found in the main bundle.
    ///   - `BundleDataServiceError.invalidFormat`: If the content of the plist file cannot be parsed as a dictionary.
    ///   - `BundleDataServiceError.missingURL`: If the specified key is not found in the plist file.
    func retrieveDownloadURL(from resourceFile: String, basedOn key: String) throws -> String {
        guard let path = Bundle.main.path(forResource: resourceFile, ofType: "plist") else {
            throw BundleDataServiceError.missingFile
        }
        
        let data = try Data(contentsOf: URL(filePath: path))
        let plist = try PropertyListDecoder().decode([String: String].self, from: data)
        
        guard let downloadURL = plist[key] else {
            throw BundleDataServiceError.missingURL
        }
        
        return downloadURL
    }
}
