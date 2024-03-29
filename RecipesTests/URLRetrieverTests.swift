//
//  URLRetrieverTests.swift
//  RecipesTests
//
//  Created by CJ on 3/20/24.
//

import XCTest
@testable import Recipes

final class URLRetrieverTests: XCTestCase {
    var urlRetriever: URLRetriever!

    override func setUpWithError() throws {
        urlRetriever = URLRetriever()
    }

    override func tearDownWithError() throws {
        urlRetriever = nil
    }
    
    func testRetrieveDownloadURL_Success() {
        let file = "URLDic"
        let key = "Categories_URL"
        let expectedURL = "https://www.themealdb.com/api/json/v1/1/categories.php"
        
        do {
            let url = try urlRetriever.retrieveDownloadURL(from: file, basedOn: key)
            XCTAssertEqual(url, expectedURL)
        } catch {
            XCTFail("Failed to retrieve download url.")
        }
    }
    
    func testRetrieveDownloadURL_Failure_MissingFile() {
        let file = "Invalid_File"
        let key = "Categories_URL"
        
        do {
            _ = try urlRetriever.retrieveDownloadURL(from: file, basedOn: key)
        } catch {
            XCTAssertEqual(error as? BundleDataServiceError, .missingFile)
        }
    }
    
    func testRetrieveDownloadURL_Failure_MissingURL() {
        let file = "URLDic"
        let key = "INVALID_API_ADDRESS"
        
        do {
            _ = try urlRetriever.retrieveDownloadURL(from: file, basedOn: key)
        } catch {
            XCTAssertEqual(error as? BundleDataServiceError, .missingURL)
        }
    }
}



