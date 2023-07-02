//
//  IngredientDetail.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/30/23.
//

import Foundation


struct IngredientDetail: Decodable, Hashable {
    let id: String
    let ingredient: String
    let ingredientImageURL: URL
    let measurement: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: IngredientDetail, rhs: IngredientDetail) -> Bool {
        lhs.id == rhs.id
    }
}
