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
            return response.meals
        }
    }
}
