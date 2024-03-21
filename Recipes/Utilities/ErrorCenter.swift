//
//  ErrorCenter.swift
//  Recipes
//
//  Created by CJ on 3/5/24.
//

import Foundation

enum NetworkDataServiceError: Error {
    case invalidURL
    case invalidHTTPResponse
}

extension NetworkDataServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            NSLocalizedString("The URL provided is not valid. Please check that you have entered the correct URL and try again.", comment: "invalidURL")
        case .invalidHTTPResponse:
            NSLocalizedString("The server returned an unexpected response. Please try again later or contact the server administrator.", comment: "invalidHTTPResponse")
        }
    }
}

enum BundleDataServiceError: Error {
    case missingFile
    case missingURL
}

extension BundleDataServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingFile:
            NSLocalizedString("Error: Missing Config.plist file.", comment: "missingFile")
        case .missingURL:
            NSLocalizedString("Error: Missing Dessert API address in the configuration file.", comment: "missingURL")
        }
    }
}
