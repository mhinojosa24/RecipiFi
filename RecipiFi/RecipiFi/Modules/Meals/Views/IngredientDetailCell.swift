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
    
    var model: IngredientDetail? {
        didSet {
            setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setup() {
        guard let model = model else { return }
        ingredientImageView.kf.setImage(with: model.ingredientImageURL, placeholder: UIImage(named: "photo.fill"), options: [.transition(.fade(1)), .cacheOriginalImage])
        ingredientName.text = model.ingredient
        measurement.text = model.measurement
    }
    
}
