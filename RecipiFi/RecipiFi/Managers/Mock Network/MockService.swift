//
//  MockService.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 7/4/23.
//

import Foundation


/// This class sole purpose is to mock `Service` class functionality
class MockService: Service, Mockable {
    func request<T>(_ resource: ApiRequest<T>, completionHandler: @escaping ApiHandler<T>)  {
        return loadJson(filename: "MockData",
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
