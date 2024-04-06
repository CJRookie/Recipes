//
//  CategoryManagerTests.swift
//  RecipesTests
//
//  Created by CJ on 4/5/24.
//

import XCTest
@testable import Recipes

final class CategoryManagerTests: XCTestCase {
    var manager: CategoryManager!
    var mockNetworkDataService: NetworkDataService!
    var mockBundleDataService: BundleDataService!
    
    override func setUpWithError() throws {
        mockNetworkDataService = MockNetworkDataService()
        manager = CategoryManager(networkDataService: mockNetworkDataService, bundleDataService: MockBundleDataService())
    }

    override func tearDownWithError() throws {
        mockNetworkDataService = nil
        mockBundleDataService = nil
        manager = nil
    }
    
    func testFetchCategories_Success() async {
        XCTAssertTrue(manager.categories.isEmpty)
        
        await manager.fetchCategories()
        
        XCTAssertNotNil(manager.categories)
    }
    
    struct MockNetworkDataService: NetworkDataService {
        var urlSession: URLSession = .shared
        
        func downloadData(from url: URL) async throws -> (Data, URLResponse) {
            let categories = Categories(categories: [Category(id: "id", name: "name", thumb: "thumb")])
            let data = try JSONEncoder().encode(categories)
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (data, response)
        }
        
        func fetch<T>(from url: URL) async throws -> T where T : Decodable {
            let result = try await downloadData(from: url)
            let decodedData = try JSONDecoder().decode(T.self, from: result.0)
            return decodedData
        }
    }
}
