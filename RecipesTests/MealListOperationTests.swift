//
//  MealListOperationTests.swift
//  RecipesTests
//
//  Created by CJ on 4/6/24.
//

import XCTest
@testable import Recipes

final class MealListOperationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFilter_EmptySearchText() {
        let samples: [Meal] = [Meal(name: "sample1", thumb: "", id: ""), Meal(name: "sample2", thumb: "", id: ""), Meal(name: "sample3", thumb: "", id: ""), Meal(name: "meal", thumb: "", id: "")]
        let searchText = ""
        
        let filtered = MealListOperation.filter(samples, by: searchText)
        
        XCTAssertEqual(filtered, samples)
    }
    
    func testFilter_NonEmptySearchText() {
        let samples: [Meal] = [Meal(name: "sample1", thumb: "", id: ""), Meal(name: "sample2", thumb: "", id: ""), Meal(name: "sample3", thumb: "", id: ""), Meal(name: "meal", thumb: "", id: "")]
        let searchText = "sample"
        
        let filtered = MealListOperation.filter(samples, by: searchText)
        
        XCTAssertFalse(filtered.isEmpty)
        XCTAssertTrue(filtered.count == 3)
    }
}
