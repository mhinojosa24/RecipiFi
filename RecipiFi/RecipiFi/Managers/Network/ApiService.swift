//
//  ApiService.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/29/23.
//

import Foundation

typealias JSONDictionary = [String: Any]
typealias ApiHandler<T> = (Result<T?, Error>) -> Void

protocol Service {
    func request<T>(_ request: ApiRequest<T>, completionHandler: @escaping ApiHandler<T>)
}


class ApiService: Service {
    private(set) var session: URLSession?

    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T>(_ request: ApiRequest<T>, completionHandler: @escaping ApiHandler<T>) {
        session?.request(request.url, then: { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completionHandler(.failure(NetworkError.responseError))
            }
            
            self.handleResponse(data, resource: request, handler: completionHandler)
        })
    }
    
    private func handleResponse<T>(_ data: Data?, resource: ApiRequest<T>, handler: @escaping ApiHandler<T>) {
        if let data = data {
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? JSONDictionary {
                    handler(.success(resource.parser(json)))
                }
            } catch {
                handler(.failure(NetworkError.decodingError))
            }
        }
    }
}
