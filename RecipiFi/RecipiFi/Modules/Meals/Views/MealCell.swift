//
//  MealCell.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/30/23.
//

import UIKit
import Kingfisher

class MealCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var thumbnailGradient: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static var reuseIdentifier: String { String(describing: self) }
    
    var model: Meal? {
        didSet {
            setup()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnail.image = nil
        thumbnail.kf.cancelDownloadTask()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnail.layer.cornerRadius = 20
        thumbnailGradient.layer.cornerRadius = 20
        applyContentShadow()
    }
    
    private func setup() {
        guard
            let model = model,
            let imageUrl = URL(string: model.strMealThumb ?? ""),
            let title = model.strMeal
        else { return }
        
        titleLabel.text = title
        thumbnail.kf.setImage(with: imageUrl, placeholder: UIImage(systemName: "photo.fill"), options: [.transition(.fade(1)), .cacheOriginalImage])
    }
    
    private func applyContentShadow() {
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.8
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        contentView.layer.shadowRadius = 3
    }
}
