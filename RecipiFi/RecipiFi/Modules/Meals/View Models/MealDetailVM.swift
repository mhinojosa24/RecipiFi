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
    var snapshot = NSDiffableDataSourceSnapshot<MealDetailSection, AnyHashable>()
    var model: MealDetail?
    
    func updateDataSource() {
        DispatchQueue.main.async {
            guard self.datasource != nil else { return }
            guard let model = self.model, let items = model.ingredientDetails else { return }
            let instuctionItems: [InstructionsDetail] = [.init(id: UUID().uuidString, instructions: model.strInstructions ?? "")]
            self.snapshot.deleteAllItems()
            self.snapshot.appendSections(MealDetailSection.allCases)
            self.snapshot.appendItems(instuctionItems, toSection: .mealInstructions)
            self.snapshot.appendItems(items, toSection: .mealIngredients)
            self.datasource.apply(self.snapshot, animatingDifferences: true)
        }
    }
}
