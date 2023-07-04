//
//  Instructions.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 7/3/23.
//

import Foundation


struct InstructionsDetail: Hashable {
    let id: String
    let instructions: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: InstructionsDetail, rhs: InstructionsDetail) -> Bool {
        lhs.id == rhs.id
    }
}
