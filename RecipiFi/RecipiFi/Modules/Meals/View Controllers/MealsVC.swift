//
//  MealsVC.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/29/23.
//

import UIKit

class MealsVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    let viewModel = MealsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        navigationController?.view.backgroundColor = .systemBackground
        let mealCell = UINib(nibName: String(describing: MealCell.self), bundle: nil)
        tableView.delegate = self
        tableView.register(mealCell, forCellReuseIdentifier: MealCell.reuseIdentifier)
        tableView.rowHeight = 100
    }
    
    private func setupObservers() {
        viewModel.datasource = TableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, model in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MealCell.reuseIdentifier, for: indexPath) as? MealCell else {
                return UITableViewCell()
            }
            
            cell.model = model
            return cell
        })
    }
}


extension MealsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
