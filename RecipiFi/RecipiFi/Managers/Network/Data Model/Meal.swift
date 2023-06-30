//
//  Meal.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/29/23.
//

import Foundation


struct Meal: Decodable, Hashable {
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(idMeal)
    }
    
    static func == (lhs: Meal, rhs: Meal) -> Bool {
        lhs.idMeal == rhs.idMeal
    }
}
