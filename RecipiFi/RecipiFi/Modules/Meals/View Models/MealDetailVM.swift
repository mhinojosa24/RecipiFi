//
//  MealDetailVM.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/30/23.
//

import Foundation
import UIKit


class MealDetailVM: BaseVM {
    
    // MARK: Variables
    var datasource: MealsDetailTableViewDiffableDataSource!
    var snapshot = NSDiffableDataSourceSnapshot<MealDetailSection, AnyHashable>()
    var model: MealDetail?
    
    /// This method takes a snapshot of data & diffable data source applies it with any animating difference
    func updateDataSource() {
        DispatchQueue.main.async {
            guard self.datasource != nil else { return }
            guard let model = self.model, let items = model.ingredientDetails else { return }
            let instructionItems: [InstructionsDetail] = [.init(id: UUID().uuidString, instructions: model.strInstructions ?? "")]
            self.snapshot.deleteAllItems()
            self.snapshot.appendSections(MealDetailSection.allCases)
            self.snapshot.appendItems(instructionItems, toSection: .mealInstructions)
            self.snapshot.appendItems(items, toSection: .mealIngredients)
            self.datasource.apply(self.snapshot, animatingDifferences: true)
        }
    }
}
