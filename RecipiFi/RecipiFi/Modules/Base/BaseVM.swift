//
//  BaseVM.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 6/30/23.
//

import Foundation


class BaseVM {
    private(set) var service: Service?
    
    init(service: Service = ApiService()) {
        self.service = service
    }
}
