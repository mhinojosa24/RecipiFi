//
//  MockGetDessertAPIRequest.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 7/4/23.
//

import Foundation


class MockGetDessertApiRequest: ApiRequest<[Meal]> {
    
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
                print("MOCK ERROR: Parsing Error")
            }
            return meals
        }
    }
}
