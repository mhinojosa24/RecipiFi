//
//  GetDessertMeals.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/29/23.
//

import Foundation


class GetDessertMeals: ApiRequest<[Meal]> {
    
    init() {
        super.init(endpoint: .getDessertMeals())
        parser = { response in
            guard let response = response["meals"] as? [JSONDictionary], let jsonData = try? JSONSerialization.data(withJSONObject: response) else {
                return []
            }
            var meals: [Meal]?
            do {
                meals = try JSONDecoder().decode([Meal].self, from: jsonData)
            } catch {
                print("Parsing Error")
            }
            return meals
        }
    }
}
