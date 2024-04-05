//
//  ImageCenterTests.swift
//  RecipesTests
//
//  Created by CJ on 4/5/24.
//

import XCTest
@testable import Recipes

final class ImageCenterTests: XCTestCase {
    var imageCenter: ImageCenter!
    var mockNetworkDataRetriever: NetworkDataService!
    var mockURLCache: URLCache!

    override func setUpWithError() throws {
        mockNetworkDataRetriever = MockNetworkDataService()
        mockURLCache = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 0)
        imageCenter = ImageCenter(imageCache: ImageCache(urlCache: mockURLCache, networkDataRetriever: mockNetworkDataRetriever))
    }

    override func tearDownWithError() throws {
        mockURLCache.removeAllCachedResponses()
        imageCenter = nil
        mockNetworkDataRetriever = nil
        mockURLCache = nil
    }
    
    func testGetImage_FetchFromURL() async throws {
        mockURLCache.removeAllCachedResponses()
        let url = "http://photo.com"
        let expectation = XCTestExpectation(description: "Fetch image from a URL")
        
        let result = await imageCenter.getImage(from: url)
        XCTAssertNotNil(result)
        expectation.fulfill()
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    func testGetImage_FetchFromCache() async throws {
        mockURLCache.removeAllCachedResponses()
        let strURL = "http://photo.fill.com"
        let url = URL(string: strURL)!
        let expectation = XCTestExpectation(description: "Fetch image from cache")
        let imageData = UIImage(systemName: "photo.fill")!.pngData()!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let cachedResponse = CachedURLResponse(response: response, data: imageData, storagePolicy: .allowedInMemoryOnly)
        let request = URLRequest(url: url)
        mockURLCache.storeCachedResponse(cachedResponse, for: request)
        
        let result = await imageCenter.getImage(from: strURL)
        XCTAssertNotNil(result)
        XCTAssertEqual(imageData.count, result?.pngData()!.count)
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 2.0)
    }

}
