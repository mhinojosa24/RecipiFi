//
//  GetMealDetails.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/30/23.
//

import Foundation


class GetMealDetails: ApiRequest<Any> {
    
    init(mealID: String) {
        super.init(endpoint: .getMealDetails(mealID: mealID))
        parser = { response in
            var result: MealDetail?
            if let response = (response["meals"] as? [JSONDictionary])?.first, let jsonData = try? JSONSerialization.data(withJSONObject: response) {
                do {
                    result = try JSONDecoder().decode(MealDetail.self, from: jsonData)
                    let ingredientDetails = result?.parseIngredientDetail(response: response)
                    result?.ingredientDetails = ingredientDetails
                } catch {
                    print(error.localizedDescription)
                }
            }
            return result
        }
    }
}
