//
//  MealsVC.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/29/23.
//

import UIKit
import Combine

class MealsVC: BaseVC {
    
    // NOTE: structure for UI constants
    struct UIConstants {
        let mealCell = UINib(nibName: String(describing: MealCell.self), bundle: nil)
        let rowHeight: CGFloat = 200
        let fallbackTableViewCell = UITableViewCell()
    }
    
    // MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Variables & Constants
    let viewModel = MealsVM()
    let uiConstants = UIConstants()
    var subscribers = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObservers()
        viewModel.callApiToGetDessertMeals()
    }
    
    // MARK: - User Defined Methods
    
    /// This method setup any UI configuration
    private func setupUI() {
        navigationController?.view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.register(uiConstants.mealCell, forCellReuseIdentifier: MealCell.reuseIdentifier)
        tableView.rowHeight = uiConstants.rowHeight
    }
    
    /// This method is purely to set up observers
    private func setupObservers() {
        viewModel.datasource = MealsTableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, model in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MealCell.reuseIdentifier, for: indexPath) as? MealCell else {
                return self.uiConstants.fallbackTableViewCell
            }
            
            cell.model = model
            return cell
        })
        
        viewModel.$mealID.receive(on: RunLoop.main).sink(receiveValue: { id in
            self.callApiToGetMealDetailInfo(id)
        }).store(in: &subscribers)
    }
    
    private func callApiToGetMealDetailInfo(_ id: String) {
        if !id.isEmpty {
            progressIndicator.showSpinner(to: view)
            viewModel.callApiToGetMealDetailInfo(mealID: id) { model in
                self.progressIndicator.removeSpinner(on: self.view)
                self.navigateToMealDetailVC(model)
            }
        }
    }
    
    private func navigateToMealDetailVC(_ model: MealDetail?) {
        guard let mealDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MealDetailVC") as? MealDetailVC else { return }
        mealDetailVC.viewModel.model = model
        navigationController?.pushViewController(mealDetailVC, animated: true)
    }
}


// MARK: - UITableView Delegates

extension MealsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = viewModel.datasource.itemIdentifier(for: indexPath), let itemID = model.idMeal else { return }
        viewModel.mealID = itemID
    }
}
