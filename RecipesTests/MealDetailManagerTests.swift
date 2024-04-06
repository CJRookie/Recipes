//
//  MealDetailManagerTests.swift
//  RecipesTests
//
//  Created by CJ on 4/5/24.
//

import XCTest
@testable import Recipes

final class MealDetailManagerTests: XCTestCase {
    var manager: MealDetailManager!
    var mockNetworkDataService: NetworkDataService!
    var mockBundleDataService: BundleDataService!
    
    override func setUpWithError() throws {
        mockNetworkDataService = MockNetworkDataService()
        manager = MealDetailManager(networkDataService: mockNetworkDataService, bundleDataService: MockBundleDataService())
    }

    override func tearDownWithError() throws {
        mockNetworkDataService = nil
        mockBundleDataService = nil
        manager = nil
    }
    
    func testFetchCategories_Success() async {
        XCTAssertNil(manager.detail.0)
        XCTAssertNil(manager.detail.1)
        
        await manager.fetchDetail(for: "MockMeal")
        
        XCTAssertNotNil(manager.detail.0)
        XCTAssertNil(manager.detail.1)
    }
    
    struct MockNetworkDataService: NetworkDataService {
        var urlSession: URLSession = .shared
        
        func downloadData(from url: URL) async throws -> (Data, URLResponse) {
            let mealDetails = MealDetails(meals: [Detail(id: "id", meal: "meal", instructions: "instructions", ingredient1: "", ingredient2: "", ingredient3: "", ingredient4: "", ingredient5: "", ingredient6: "", ingredient7: "", ingredient8: "", ingredient9: "", ingredient10: "", ingredient11: "", ingredient12: "", ingredient13: "", ingredient14: "", ingredient15: "", ingredient16: "", ingredient17: "", ingredient18: "", ingredient19: "", ingredient20: "", measure1: "", measure2: "", measure3: "", measure4: "", measure5: "", measure6: "", measure7: "", measure8: "", measure9: "", measure10: "", measure11: "", measure12: "", measure13: "", measure14: "", measure15: "", measure16: "", measure17: "", measure18: "", measure19: "", measure20: "")])
            let data = try JSONEncoder().encode(mealDetails)
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
