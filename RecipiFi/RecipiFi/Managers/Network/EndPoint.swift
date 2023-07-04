//
//  EndPoint.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/29/23.
//

import Foundation

/// This struct is an endpoint factory
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
    
    static func getMealDetails(mealID: String) -> Self {
        EndPoint(path: "/api/json/v1/1/lookup.php", queryItems: [
            .init(name: "i", value: mealID)
        ])
    }
    
    static func getIngredientImageURL(ingredient: String) -> URL {
        let fallbackURL = URL(string: "https://www.themealdb.com/images/ingredients/Flour-Small.png")
        if let urlString = "https://www.themealdb.com/images/ingredients/\(ingredient)-Small.png"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlString) {
            return url
        }
        return fallbackURL!
    }
}
