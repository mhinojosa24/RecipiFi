//
//  MockService.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 7/4/23.
//

import Foundation

protocol MockService: Service, Mockable {
    func request<T>(_ resource: ApiRequest<T>, mockFileName: MockDataFileName, completionHandler: @escaping ApiHandler<T>)
}

/// This class sole purpose is to mock `Service` class functionality
class MockApiService: MockService {
    
    func request<T>(_ resource: ApiRequest<T>, mockFileName: MockDataFileName, completionHandler: @escaping ApiHandler<T>)  {
        return loadJson(filename: mockFileName,
                        extensionType: .json,
                        type: JSONDictionary.self) { result in
            switch result {
            case .success(let response):
                completionHandler(.success(resource.parser(response)))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

extension MockApiService {
    func request<T>(_ request: ApiRequest<T>, completionHandler: @escaping ApiHandler<T>) {
        
    }
}
