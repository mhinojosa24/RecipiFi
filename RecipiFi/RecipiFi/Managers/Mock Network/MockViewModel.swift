//
//  MockViewModel.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 7/4/23.
//

import Foundation


class MockViewModel {
    private(set) var service: MockApiService?
    
    let mockGetDessertApiRequest = MockGetDessertApiRequest()
    let mockGetDessertDetailsApiRequest = MockGetDessertDetailsApiRequest(mealID: "53049")
    
    init(service: MockApiService) {
        self.service = service
    }
    
    func loadMockData(type: MockDataFileName) -> Data? {
        return service?.loadJsonData(filename: type, extensionType: .json)
    }
    
    func callApiToGetDessertMeals(completionHandler: @escaping (Result<[Meal], Error>) -> Void) {
        service?.request(mockGetDessertApiRequest, mockFileName: .dessertMeals, completionHandler: { result in
            switch result {
            case .success(let meal):
                if let meal = meal {
                    completionHandler(.success(meal))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
    
    func callApiToGetDessertDetails(completionHandler: @escaping (Result<MealDetail, Error>) -> Void) {
        service?.request(mockGetDessertDetailsApiRequest, mockFileName: .dessertDetails, completionHandler: { result in
            switch result {
            case .success(let mealDetails):
                if let mealDetails = mealDetails as? MealDetail {
                    completionHandler(.success(mealDetails))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
}
