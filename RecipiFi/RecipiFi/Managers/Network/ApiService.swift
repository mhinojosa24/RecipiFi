//
//  ApiService.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/29/23.
//

import Foundation


typealias ApiHandler<T> = (Result<T, Error>) -> Void

protocol Service {
    func request<T: Decodable>(_ request: ApiRequest<T>, completionHandler: @escaping ApiHandler<T>)
}


class ApiService: Service {
    private(set) var session: URLSession?

    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ request: ApiRequest<T>, completionHandler: @escaping ApiHandler<T>) {
        session?.request(<#T##url: URL##URL#>, then: <#T##URLSession.Handler##URLSession.Handler##(Data?, URLResponse?, Error?) -> Void#>)
    }
}
