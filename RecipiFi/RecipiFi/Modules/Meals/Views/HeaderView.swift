//
//  HeaderView.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 7/2/23.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var numberOfItemsLabel: UILabel!
    
    var numberOfItems: Int? {
        didSet {
            setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setup() {
        guard let numberOfItems = numberOfItems else { return }
        numberOfItemsLabel.text = "\(numberOfItems) item"
    }
}
