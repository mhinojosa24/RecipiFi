//
//  MealsVM.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/30/23.
//

import Foundation


class MealsVM: BaseVM {
    
    func callApiToGetDessertMeals() {
        service?.request(GetDessertMeals()) { result in
            switch result {
            case .success:
                break
            case .failure:
                break
            }
        }
    }
}
