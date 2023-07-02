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
        view.backgroundColor = self.traitCollection.userInterfaceStyle == .dark ? .black : .white
        
        
    }
}
