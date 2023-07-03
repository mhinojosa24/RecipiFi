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
    @IBOutlet var tableView: UITableView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    
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
        thumbnailImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "photo.fill"), options: [.transition(.fade(1)), .cacheOriginalImage])
        titleLabel.text = viewModel.model?.strMeal ?? ""
    }
    
    private func setupTableView() {
        let ingredientDetailCell = UINib(nibName: String(describing: IngredientDetailCell.self), bundle: nil)
        let headerView = UINib(nibName: String(describing: HeaderView.self), bundle: nil)
        
        tableView.delegate = self
        tableView.register(ingredientDetailCell, forCellReuseIdentifier: IngredientDetailCell.reuseIdentifier)
        tableView.register(headerView, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.rowHeight = 58
        tableView.sectionHeaderHeight = 58
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
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? HeaderView
        headerView?.numberOfItems = viewModel.model?.ingredientDetails?.count
        return headerView
    }
}
