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
    @IBOutlet weak var instructionStackView: UIStackView!
    @IBOutlet weak var ingredientStackView: UIStackView!
    @IBOutlet weak var descriptionsLabel: UILabel!
    
    static var reuseIdentifier: String { String(describing: self) }
    
    var ingredientModel: IngredientDetail? {
        didSet {
            setupUIForIngredients()
        }
    }
    
    var instructionModel: InstructionsDetail? {
        didSet {
            setupUIForInstructions()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ingredientImageView.image = nil
        ingredientImageView.kf.cancelDownloadTask()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ingredientImageView.layer.cornerRadius = 10
    }
    
    private func setupUIForIngredients() {
        guard let model = ingredientModel else { return }
        instructionStackView.isHidden = true
        ingredientStackView.isHidden = false
        ingredientImageView.kf.setImage(with: model.ingredientImageURL, placeholder: UIImage(named: "photo.fill"), options: [.transition(.fade(1)), .cacheOriginalImage])
        ingredientName.text = model.ingredient
        measurement.text = model.measurement
    }
    
    private func setupUIForInstructions() {
        guard let model = instructionModel else { return }
        instructionStackView.isHidden = false
        ingredientStackView.isHidden = true
        descriptionsLabel.text = model.instructions
    }
    
}
