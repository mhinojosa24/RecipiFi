//
//  MealDetailVM.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/30/23.
//

import Foundation
import UIKit


class MealDetailVM: BaseVM {
    
    var datasource: MealsDetailTableViewDiffableDataSource!
    var snapshot = NSDiffableDataSourceSnapshot<String?, IngredientDetail>()
    var model: MealDetail?
}
