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
    
    func testMockGetDessertApiRequest() throws {
        let getDessertRequest = mockViewModel.mockGetDessertApiRequest
        XCTAssertTrue(getDessertRequest.url.scheme == "https")
        XCTAssertTrue(getDessertRequest.url.host() == Bundle.main.infoDictionary?["SERVER_URL"] as? String ?? "")
        XCTAssertTrue(getDessertRequest.url.path() == "/api/json/v1/1/filter.php")
        XCTAssertTrue(getDessertRequest.url.query() == "c=Dessert")
        
        let getDessertDetailsRequest = mockViewModel.mockGetDessertDetailsApiRequest
        XCTAssertTrue(getDessertDetailsRequest.url.scheme == "https")
        XCTAssertTrue(getDessertDetailsRequest.url.host() == Bundle.main.infoDictionary?["SERVER_URL"] as? String ?? "")
        XCTAssertTrue(getDessertDetailsRequest.url.path() == "/api/json/v1/1/lookup.php")
        XCTAssertTrue(getDessertDetailsRequest.url.query() == "i=53049")
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
    
    func testGetDessertDetails() throws {
        let response = HTTPURLResponse(url: mockViewModel.mockGetDessertDetailsApiRequest.url,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"]) ?? HTTPURLResponse()
        
        let mockData: Data = mockViewModel.loadMockData(type: .dessertDetails) ?? Data()
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        
        mockViewModel.callApiToGetDessertDetails { result in
            switch result {
            case .success(let mealDetails):
                XCTAssertEqual(mealDetails.idMeal, "53049")
                XCTAssertEqual(mealDetails.strMeal, "Apam balik")
                expectation.fulfill()
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        }
        wait(for: [expectation], timeout: 2)
    }
}
