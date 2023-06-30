//
//  URLSession.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/29/23.
//

import Foundation


extension URLSession {
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func request(_ url: URL, then handler: @escaping Handler) -> URLSessionDataTask {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = dataTask(with: request, completionHandler: handler)
        task.resume()
        return task
    }
}
