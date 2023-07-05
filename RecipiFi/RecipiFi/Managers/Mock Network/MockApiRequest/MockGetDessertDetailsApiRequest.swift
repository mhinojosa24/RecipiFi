//
//  MockGetDessertDetailsApiRequest.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 7/4/23.
//

import Foundation


class MockGetDessertDetailsApiRequest: ApiRequest<[MealDetail]> {
    
    init(mealID: String) {
        super.init(endpoint: .getMealDetails(mealID: mealID))
        parser = { response in
            return []
        }
    }
}
