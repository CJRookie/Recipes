//
//  RecipeDataRetrieverTests.swift
//  RecipeDataRetrieverTests
//
//  Created by CJ on 3/18/24.
//

import XCTest
@testable import Recipes

final class RecipeDataRetrieverTests: XCTestCase {
    var retriever: RecipeDataRetriever!
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }()
    
    override func setUpWithError() throws {
        retriever = RecipeDataRetriever(urlSession: session)
    }
    
    override func tearDownWithError() throws {
        retriever = nil
        MockURLProtocol.requestHandler = nil
        URLProtocol.unregisterClass(MockURLProtocol.self)
    }
    
    func testDownloadData_Success() async throws {
        let expectation = XCTestExpectation(description: "Download data successful")
        let url = "https://example.com"
        let mockData = """
        {
        "categories":[{"idCategory":"1","strCategory":"Beef"}]
        }
        """
        let data = mockData.data(using: .utf8)!
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: url)!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        do {
            let result = try await retriever.downloadData(from: url)
            XCTAssertEqual(result.0, data)
            expectation.fulfill()
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    func testDownloadData_Failure_InvalidHTTPResponse() async throws {
        let expectation = XCTestExpectation(description: "Invalid HTTP response failure")
        let url = "https://example.com"
        let mockData = """
        {
        "categories":[{"idCategory":"1","strCategory":"Beef"}]
        }
        """
        let data = mockData.data(using: .utf8)!
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: url)!, statusCode: 400, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        do {
            _ = try await retriever.downloadData(from: url)
        } catch {
            XCTAssertEqual(error as? NetworkDataServiceError, .invalidHTTPResponse)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    func testFetchData_Success() async throws {
        let expectation = XCTestExpectation(description: "Fetch data successful")
        let url = "https://example.com"
        let mockData = Categories(categories: [Category(id: "1", category: "Beef", categoryThumb: "http://beef.com")])
        let data = try JSONEncoder().encode(mockData)
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: url)!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        do {
            let result: Categories = try await retriever.fetch(from: url)
            XCTAssertEqual(result, mockData)
            expectation.fulfill()
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
}
