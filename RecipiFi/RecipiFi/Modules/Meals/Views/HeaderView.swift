//
//  HeaderView.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 7/2/23.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {
    
    // MARK: - IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberOfItemsLabel: UILabel!
    
    static var reuseIdentifier: String { String(describing: self) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// This method setup any UI configuration
    func setup(title: String, totalItems: Int, shouldDisplayNumberOfItems: Bool) {
        titleLabel.text = title
        numberOfItemsLabel.text = "\(totalItems) item"
        numberOfItemsLabel.isHidden = !shouldDisplayNumberOfItems
    }
}
