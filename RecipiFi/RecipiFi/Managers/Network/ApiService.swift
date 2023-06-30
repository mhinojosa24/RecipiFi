//
//  ApiService.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/29/23.
//

import Foundation


typealias ApiHandler<T> = (Result<T?, Error>) -> Void

protocol Service {
    func request<T: Decodable>(_ request: ApiRequest<T>, completionHandler: @escaping ApiHandler<T>)
}


class ApiService: Service {
    private(set) var session: URLSession?

    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ request: ApiRequest<T>, completionHandler: @escaping ApiHandler<T>) {
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
                let response: Response = try JSONDecoder().decode(Response.self, from: data)
                handler(.success(resource.parser(response)))
            } catch {
                handler(.failure(NetworkError.decodingError))
            }
        }
    }
}
