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
        let ingredientDetailCell = UINib(nibName: String(describing: IngredientDetailCell.self), bundle: nil)
        tableView.register(ingredientDetailCell, forCellReuseIdentifier: IngredientDetailCell.reuseIdentifier)
        tableView.rowHeight = 58
        guard let imageUrl = URL(string: viewModel.model?.strMealThumb ?? "") else { return }
        thumbnailImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "photo.fill"), options: [.transition(.fade(1)), .cacheOriginalImage])
        titleLabel.text = viewModel.model?.strMeal ?? ""
    }
    
    private func setupObservers() {
        viewModel.datasource = MealsDetailTableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, model in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientDetailCell.reuseIdentifier, for: indexPath) as? IngredientDetailCell else { return UITableViewCell() }
            cell.model = model
            return cell
        })
    }
}
