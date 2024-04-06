//
//  MockNetworkDataService.swift
//  RecipesTests
//
//  Created by CJ on 4/5/24.
//

import Foundation
@testable import Recipes
import UIKit

struct MockNetworkDataService: NetworkDataService {
    var urlSession: URLSession = .shared
    
    func fetch<T>(from url: URL) async throws -> T where T : Decodable {
        return "" as! T
    }
    
    func downloadData(from url: URL) async throws -> (Data, URLResponse) {
        let imageData = UIImage(systemName: "photo")!.pngData()!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        return (imageData, response)
    }
}
