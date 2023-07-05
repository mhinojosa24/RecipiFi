//
//  RecipiFiTests.swift
//  RecipiFiTests
//
//  Created by Maximo Hinojosa on 6/29/23.
//

import XCTest
@testable import RecipiFi

final class RecipiFiTests: XCTestCase {
    var mockService: MockApiService!
    var mockViewModel: MockViewModel!

    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        mockService = MockApiService()
        mockViewModel = MockViewModel(service: mockService)
    }

    override func tearDown() {
        mockService = nil
        mockViewModel = nil
        super.tearDown()
    }
    
    func testGetDessertMeals() throws {
        let response = HTTPURLResponse(url: mockViewModel.mockGetDessertApiRequest.url,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"]) ?? HTTPURLResponse()
        
        let mockData: Data = mockViewModel.loadMockData(type: .dessertMeals) ?? Data()
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        
        mockViewModel.callApiToGetDessertMeals { result in
            switch result {
            case .success(let meals):
                XCTAssertEqual(meals.first?.idMeal, "53049")
                expectation.fulfill()
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        }
        wait(for: [expectation], timeout: 2)
    }
}
