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
    
    // Variables & Publishers
    var datasource: MealsTableViewDiffableDataSource!
    var snapshot = NSDiffableDataSourceSnapshot<String?, Meal>()
    @Published var mealID: String = ""
    
    
    /// This method pings the api to get dessert meals
    func callApiToGetDessertMeals(completionHandler: @escaping () -> Void) {
        service?.request(GetDessertMeals()) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let meals):
                    if let meals = meals {
                        self.updateDataSource(with: meals)
                        completionHandler()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler()
                }
            }
        }
    }
    
    
    /// This method pings the api more info on specified meal
    /// - Parameters:
    ///   - mealID: String
    ///   - completionHandler: returns `MealDetail` object when successful
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
    
    /// This method takes a snapshot of data & diffable data source applies it with any animating difference
    /// - Parameter meals: array `Meal` Object
    private func updateDataSource(with meals: [Meal]) {
        guard self.datasource != nil else { return }
        self.snapshot.deleteAllItems()
        self.snapshot.appendSections([""])
        self.snapshot.appendItems(meals, toSection: "")
        self.datasource.apply(self.snapshot, animatingDifferences: true)
    }
}
