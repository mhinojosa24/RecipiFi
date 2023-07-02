//
//  MealDetail.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/30/23.
//

import Foundation


struct MealDetail: Decodable {
    let idMeal: String?
    let strMeal: String?
    let strInstructions: String?
    let strMealThumb: String? 
    var ingredientDetails: [IngredientDetail]?
}

extension MealDetail {
    func parseIngredientDetail(response: JSONDictionary) -> [IngredientDetail] {
        var ingredientInfo = [IngredientDetail]()
        for i in 1...20 where !(response["strIngredient\(i)"] as? String ?? "").isEmpty && !(response["strMeasure\(i)"] as? String ?? "").isEmpty {
            
            if let ingredient = response["strIngredient\(i)"] as? String,
               let measurement = response["strMeasure\(i)"] as? String {
                
                ingredientInfo.append(.init(id: UUID().uuidString,
                                            ingredient: ingredient,
                                            ingredientImageURL: EndPoint.getIngredientImageURL(ingredient: ingredient),
                                            measurement: measurement))
            }
        }
        return ingredientInfo
    }
}
