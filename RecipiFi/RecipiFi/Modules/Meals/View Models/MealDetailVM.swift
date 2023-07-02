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
    
    func updateDataSource() {
        DispatchQueue.main.async {
            guard self.datasource != nil else { return }
            guard let items = self.model?.ingredientDetails else { return }
            self.snapshot.deleteAllItems()
            self.snapshot.appendSections([""])
            self.snapshot.appendItems(items, toSection: "")
            self.datasource.apply(self.snapshot, animatingDifferences: true)
        }
    }
}
