//
//  PersistenceProviderTest.swift
//  RecipesTests
//
//  Created by CJ on 4/4/24.
//

import XCTest
@testable import Recipes
import SwiftData

final class PersistenceProviderTest: XCTestCase {
    var provider: PersistenceProvider!

    override func setUpWithError() throws {
        provider = PersistenceProvider()
    }

    override func tearDownWithError() throws {
        let fetchedData = try provider.fetch()
        if !fetchedData.isEmpty {
            for meal in fetchedData {
                provider.delete(meal)
            }
        }
        provider = nil
    }

    func testFetchAndAddAndDelete_Success() throws {
        let samples = [Meal(name: "sample1Name", thumb: "sample1Thumb", id: "sample1"), Meal(name: "sample2Name", thumb: "sample2Thumb", id: "sample2"), Meal(name: "sample3Name", thumb: "sample3Thumb", id: "sample3")]
        
        for index in 0..<samples.count {
            provider.add(samples[index])
        }
        
        var fetchedData = try provider.fetch()
        
        XCTAssertNotNil(fetchedData)
        
        for sample in samples {
            XCTAssertTrue(fetchedData.contains(where: { $0.name == sample.name }))
        }
        
        for index in 1..<fetchedData.count {
            XCTAssertTrue(fetchedData[index].dateOfCreation > fetchedData[index - 1].dateOfCreation)
        }
        
        for meal in fetchedData {
            provider.delete(meal)
        }
        
        fetchedData = try provider.fetch()
        
        XCTAssertTrue(fetchedData.isEmpty)
    }
}
