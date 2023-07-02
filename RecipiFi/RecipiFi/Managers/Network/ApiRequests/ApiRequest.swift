//
//  ApiRequest.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/29/23.
//

import Foundation


class ApiRequest<T> {
    private(set) var url: URL
    private(set) var endpoint: Any
    var parser: (JSONDictionary) -> T?
    
    init(endpoint: EndPoint) {
        self.endpoint = endpoint
        self.url = endpoint.url
        self.parser = { _ in
            nil
        }
    }
}
