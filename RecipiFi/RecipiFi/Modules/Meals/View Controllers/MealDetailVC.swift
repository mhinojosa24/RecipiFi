//
//  MealDetailVC.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/30/23.
//

import Foundation
import UIKit
import Kingfisher

class MealDetailVC: BaseVC {
    
    // NOTE: structure for UI constants
    struct UIConstants {
        let ingredientDetailCell = UINib(nibName: IngredientDetailCell.reuseIdentifier, bundle: nil)
        let headerView = UINib(nibName: HeaderView.reuseIdentifier, bundle: nil)
        let rowHeight: CGFloat = 58
        let sectionHeaderHeight: CGFloat = 58
        let placeHolderImage = UIImage(named: "photo.fill")
    }
    
    // MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    
    // MARK: - Variables & Constants
    let uiConstants = UIConstants()
    var viewModel = MealDetailVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObservers()
        viewModel.updateDataSource()
    }
    
    // MARK: - User Defined Methods
    
    /// This method setup any UI configuration
    private func setupUI() {
        view.backgroundColor = self.traitCollection.userInterfaceStyle == .dark ? .black : .white
        setupIBOutlets()
        setupTableView()
    }
    
    private func setupIBOutlets() {
        guard let imageUrl = URL(string: viewModel.model?.strMealThumb ?? "") else { return }
        thumbnailImageView.kf.setImage(with: imageUrl, placeholder: uiConstants.placeHolderImage, options: [.transition(.fade(1)), .cacheOriginalImage])
        titleLabel.text = viewModel.model?.strMeal ?? ""
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.register(uiConstants.ingredientDetailCell, forCellReuseIdentifier: IngredientDetailCell.reuseIdentifier)
        tableView.register(uiConstants.headerView, forHeaderFooterViewReuseIdentifier: HeaderView.reuseIdentifier)
    }
    
    /// This method is purely to set up observers
    private func setupObservers() {
        viewModel.datasource = MealsDetailTableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, model in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientDetailCell.reuseIdentifier, for: indexPath) as? IngredientDetailCell else { return UITableViewCell() }
            
            if let ingredientModel = model as? IngredientDetail {
                cell.ingredientModel = ingredientModel
            }
            
            if let instructionModel = model as? InstructionsDetail {
                cell.instructionModel = instructionModel
            }
            
            return cell
        })
    }
}


// MARK: - UITableView Delegates

extension MealDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch MealDetailSection(rawValue: section) {
        case .mealInstructions:
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.reuseIdentifier) as? HeaderView
            headerView?.setup(title: "Instructions", totalItems: .zero, shouldDisplayNumberOfItems: false)
            return headerView
        case .mealIngredients:
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.reuseIdentifier) as? HeaderView
            headerView?.setup(title: "Ingredients", totalItems: viewModel.model?.ingredientDetails?.count ?? 0, shouldDisplayNumberOfItems: true)
            return headerView
        case .none:
            break
        }
        return .none
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch MealDetailSection(rawValue: section) {
        case .mealInstructions, .mealIngredients:
            return uiConstants.sectionHeaderHeight
        case .none:
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch MealDetailSection(rawValue: indexPath.section) {
        case .mealInstructions:
            return UITableView.automaticDimension
        case .mealIngredients:
            return uiConstants.rowHeight
        case .none:
            return .zero
        }
    }
}
