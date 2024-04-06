//
//  ImageCacheTests.swift
//  RecipesTests
//
//  Created by CJ on 3/20/24.
//

import XCTest
@testable import Recipes

final class ImageCacheTests: XCTestCase {
    var imageCache: ImageCache!
    var mockNetworkDataService: NetworkDataService!
    var mockURLCache: URLCache!

    override func setUpWithError() throws {
        mockNetworkDataService = MockNetworkDataService()
        mockURLCache = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 0)
        imageCache = ImageCache(urlCache: mockURLCache, networkDataService: mockNetworkDataService)
    }

    override func tearDownWithError() throws {
        mockURLCache.removeAllCachedResponses()
        imageCache = nil
        mockNetworkDataService = nil
        mockURLCache = nil
    }
    
    func testFetchImage_Success() async throws {
        let url = URL(string: "http://photo.com")!
        let expectation = XCTestExpectation(description: "Fetch an image from a URL")
        
        let result = try await imageCache.fetchImage(from: url)
        
        XCTAssertNotNil(result)
        expectation.fulfill()
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    func testCacheImage_Success() throws {
        let url = URL(string: "http://photo.com")!
        let request = URLRequest(url: url)
        let imageData = UIImage(systemName: "photo.fill")!.pngData()!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        
        XCTAssertNil(mockURLCache.cachedResponse(for: request))
        
        imageCache.cacheImage(from: url, response: response, data: imageData)
        
        XCTAssertNotNil(mockURLCache.cachedResponse(for: request))
    }
}
