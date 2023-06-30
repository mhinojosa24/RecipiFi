//
//  Response.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/29/23.
//

import Foundation


struct Response: Decodable {
    let meals: [Meal]
}
