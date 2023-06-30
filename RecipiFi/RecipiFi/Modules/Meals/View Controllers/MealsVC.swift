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
        navigationController?.view.backgroundColor = .systemBackground
    }
}
