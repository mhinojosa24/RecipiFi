//
//  ViewController.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/29/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let service = ApiService()
        service.request(GetDessertMeals()) { result in
            switch result {
            case .success:
                break
            case .failure:
                break
            }
        }
    }


}

