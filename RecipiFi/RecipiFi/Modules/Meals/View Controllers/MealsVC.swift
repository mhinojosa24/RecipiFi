//
//  MealsVC.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/29/23.
//

import UIKit
import Combine

class MealsVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    let viewModel = MealsVM()
    var subscribers = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupObservers()
        viewModel.callApiToGetDessertMeals()
    }
    
    private func configureUI() {
        navigationController?.view.backgroundColor = .systemBackground
        let mealCell = UINib(nibName: String(describing: MealCell.self), bundle: nil)
        tableView.delegate = self
        tableView.register(mealCell, forCellReuseIdentifier: MealCell.reuseIdentifier)
        tableView.rowHeight = 200
    }
    
    private func setupObservers() {
        viewModel.datasource = MealsTableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, model in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MealCell.reuseIdentifier, for: indexPath) as? MealCell else {
                return UITableViewCell()
            }
            
            cell.model = model
            return cell
        })
        
        viewModel.$mealID.receive(on: RunLoop.main).sink(receiveValue: { id in
            self.viewModel.callApiToGetMealDetailInfo(mealID: id) { model in
                guard let mealDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MealDetailVC") as? MealDetailVC else { return }
                mealDetailVC.viewModel.model = model
                self.navigationController?.pushViewController(mealDetailVC, animated: true)
            }
        }).store(in: &subscribers)
    }
}


extension MealsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = viewModel.datasource.itemIdentifier(for: indexPath), let itemID = model.idMeal else { return }
        viewModel.mealID = itemID
    }
}
