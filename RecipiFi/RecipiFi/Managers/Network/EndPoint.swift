//
//  EndPoint.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/29/23.
//

import Foundation


struct EndPoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension EndPoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Bundle.main.infoDictionary?["SERVER_URL"] as? String ?? ""
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
}

extension EndPoint {
    static func getDessertMeals() -> Self {
        EndPoint(path: "/api/json/v1/1/filter.php", queryItems: [
            .init(name: "c", value: "Dessert")
        ])
    }
}
