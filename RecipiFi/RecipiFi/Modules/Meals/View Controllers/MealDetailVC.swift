//
//  MealDetailVC.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/30/23.
//

import Foundation
import UIKit
import Kingfisher

class MealDetailVC: UIViewController {
    
    struct UIConstants {
        let ingredientDetailCell = UINib(nibName: IngredientDetailCell.reuseIdentifier, bundle: nil)
        let headerView = UINib(nibName: HeaderView.reuseIdentifier, bundle: nil)
        let rowHeight: CGFloat = 58
        let sectionHeaderHeight: CGFloat = 58
        let placeHolderImage = UIImage(named: "photo.fill")
    }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    
    let uiConstants = UIConstants()
    var viewModel = MealDetailVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObservers()
        viewModel.updateDataSource()
    }
    
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
        tableView.rowHeight = uiConstants.rowHeight
        tableView.sectionHeaderHeight = uiConstants.sectionHeaderHeight
    }
    
    private func setupObservers() {
        viewModel.datasource = MealsDetailTableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, model in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientDetailCell.reuseIdentifier, for: indexPath) as? IngredientDetailCell else { return UITableViewCell() }
            cell.model = model
            return cell
        })
    }
}

extension MealDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.reuseIdentifier) as? HeaderView
        headerView?.numberOfItems = viewModel.model?.ingredientDetails?.count
        return headerView
    }
}
