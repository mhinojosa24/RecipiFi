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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
