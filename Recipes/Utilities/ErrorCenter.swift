//
//  ErrorCenter.swift
//  Recipes
//
//  Created by CJ on 3/5/24.
//

import Foundation

enum APIServiceError: Error {
    case invalidURL
    case invalidHTTPResponse
}

extension APIServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            NSLocalizedString("The URL provided is not valid. Please check that you have entered the correct URL and try again.", comment: "invalidURL")
        case .invalidHTTPResponse:
            NSLocalizedString("The server returned an unexpected response. Please try again later or contact the server administrator.", comment: "invalidHTTPResponse")
        }
    }
}

enum ConfigurationError: Error {
    case missingFile
    case invalidFormat(String)
    case missingApiAddress
}

extension ConfigurationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingFile:
            NSLocalizedString("Error: Missing Config.plist file.", comment: "missingFile")
        case .invalidFormat(let path):
            NSLocalizedString("Error: Unable to read the configuration file at path \(path)", comment: "invalidFormat")
        case .missingApiAddress:
            NSLocalizedString("Error: Missing Dessert API address in the configuration file.", comment: "missingApiAddress")
        }
    }
}
