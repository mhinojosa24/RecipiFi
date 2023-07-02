//
//  MealsVM.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/30/23.
//

import Foundation
import Combine
import UIKit


class MealsVM: BaseVM {
    
    var datasource: TableViewDiffableDataSource!
    var snapshot = NSDiffableDataSourceSnapshot<String?, Meal>()
    @Published var mealID: String = ""
    
    func callApiToGetDessertMeals() {
        service?.request(GetDessertMeals()) { result in
            switch result {
            case .success(let meals):
                if let meals = meals { 
                    self.updateDataSource(with: meals)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func callApiToGetMealDetailInfo(mealID: String, completionHandler: @escaping (MealDetail?) -> Void) {
        service?.request(GetMealDetails(mealID: mealID), completionHandler: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let detailModel):
                    if let model = detailModel as? MealDetail {
                        completionHandler(model)
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    completionHandler(nil)
                }
            }
        })
    }
    
    private func updateDataSource(with meals: [Meal]) {
        DispatchQueue.main.async {
            guard self.datasource != nil else { return }
            self.snapshot.deleteAllItems()
            self.snapshot.appendSections([""])
            self.snapshot.appendItems(meals, toSection: "")
            self.datasource.apply(self.snapshot, animatingDifferences: true)
        }
    }
}
