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
    var parser: (Any) -> T?
    
    init(endpoint: Any) {
        self.endpoint = endpoint
        self.url = url
        self.parser = { _ in
            nil
        }
    }
}
