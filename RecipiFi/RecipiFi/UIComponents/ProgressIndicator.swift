//
//  ProgressIndicator.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 7/4/23.
//

import Foundation
import UIKit

class ProgressIndicator: UIView {
    private var activitySpinnerContainer: UIView?
    
    func showSpinner(to view: UIView) {
        frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        backgroundColor = UIColor(white: 1, alpha: 0.5)
        layer.cornerRadius = 15
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = center
        center = view.center
        view.isUserInteractionEnabled = false
        
        DispatchQueue.main.async {
            self.addSubview(activityIndicator)
            view.addSubview(self)
        }
    }
    
    func removeSpinner(on view: UIView) {
        DispatchQueue.main.async {
            view.isUserInteractionEnabled = true
            self.removeFromSuperview()
        }
    }
}

