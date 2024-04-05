//
//  FavoriteListManagerTests.swift
//  RecipesTests
//
//  Created by CJ on 3/26/24.
//

import XCTest
import SwiftData
@testable import Recipes

final class FavoriteListManagerTests: XCTestCase {
    var manager: FavoriteListManager!

    override func setUpWithError() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Meal.self, configurations: config)
        manager = FavoriteListManager(container: container)
    }

    override func tearDownWithError() throws {
        manager.fetchFavoriteRecipes()
        if !manager.recipes.isEmpty {
            for recipe in manager.recipes {
                manager.delete(recipe)
            }
        }
        manager = nil
    }
    
    func testFetchAndAddAndDelete_Success() throws {
        let samples = [Meal(name: "sample1Name", thumb: "sample1Thumb", id: "sample1"), Meal(name: "sample2Name", thumb: "sample2Thumb", id: "sample2"), Meal(name: "sample3Name", thumb: "sample3Thumb", id: "sample3")]
        
        XCTAssertTrue(manager.recipes.isEmpty)
        
        for index in 0..<samples.count {
            manager.add(samples[index])
        }
        
        manager.fetchFavoriteRecipes()
        
        for sample in samples {
            XCTAssertTrue(manager.recipes.contains(where: { $0.name == sample.name }))
        }
        
        for index in 1..<samples.count {
            XCTAssertTrue(manager.recipes[index].dateOfCreation > manager.recipes[index - 1].dateOfCreation)
        }
        
        for sample in samples {
            manager.delete(sample)
        }
        
        XCTAssertTrue(manager.recipes.isEmpty)
    }
}
