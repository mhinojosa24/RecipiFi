//
//  IngredientDetailCell.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 7/1/23.
//

import UIKit
import Kingfisher

class IngredientDetailCell: UITableViewCell {

    @IBOutlet weak var ingredientImageView: UIImageView!
    @IBOutlet weak var ingredientName: UILabel!
    @IBOutlet weak var measurement: UILabel!
    
    static var reuseIdentifier: String { String(describing: self) }
    
    var model: IngredientDetailCell? {
        didSet {
            setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setup() {
        guard let imageUrl = URL(string: "") else { return }
    }
    
}
