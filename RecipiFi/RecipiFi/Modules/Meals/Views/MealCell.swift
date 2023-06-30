//
//  MealCell.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/30/23.
//

import UIKit

class MealCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static var reuseIdentifier: String { String(describing: self) }
    
    var model: Meal? {
        didSet {
            // call method to update cell UI
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
