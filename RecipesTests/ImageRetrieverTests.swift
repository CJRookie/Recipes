//
//  ImageRetrieverTests.swift
//  RecipesTests
//
//  Created by CJ on 3/20/24.
//

import XCTest
@testable import Recipes

final class ImageRetrieverTests: XCTestCase {
    var imageCache: ImageCacheCenter!
    var mockNetworkDataRetriever: NetworkDataService!
    var mockURLCache: URLCache!

    override func setUpWithError() throws {
        mockNetworkDataRetriever = MockNetworkDataService()
        mockURLCache = URLCache(memoryCapacity: 100 * 1024 * 1024, diskCapacity: 0)
        imageCache = ImageCacheCenter(sharedURLCache: mockURLCache, networkDataRetriever: mockNetworkDataRetriever)
    }

    override func tearDownWithError() throws {
        imageCache = nil
        mockNetworkDataRetriever = nil
        mockURLCache = nil
    }
    
    func testGetRecipeImage_FetchFromURL() async throws {
        let url = "http://example.com"
        let expectation = XCTestExpectation(description: "Fetch image from a URL")
        
        let result = await imageCache.getImage(from: url)
        XCTAssertNotNil(result)
        expectation.fulfill()
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    func testGetRecipeImage_FetchFromCache() async throws {
        let strURL = "http://example.com"
        let url = URL(string: strURL)!
        let expectation = XCTestExpectation(description: "Fetch image from cache")
        let imageData = UIImage(systemName: "photo")!.pngData()!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let cachedResponse = CachedURLResponse(response: response, data: imageData, storagePolicy: .allowedInMemoryOnly)
        let request = URLRequest(url: url)
        mockURLCache.storeCachedResponse(cachedResponse, for: request)
        imageCache = ImageCacheCenter(sharedURLCache: mockURLCache, networkDataRetriever: DataRetriever())
        
        let result = await imageCache.getImage(from: strURL)
        XCTAssertNotNil(result)
        expectation.fulfill()
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    class MockNetworkDataService: NetworkDataService {
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
}
