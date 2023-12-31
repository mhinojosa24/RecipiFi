//
//  Mockable.swift
//  RecipiFi
//
//  Created by Maximo Hinojosa on 7/4/23.
//

import Foundation


enum FileExtensionType: String {
    case json = ".json"
}

enum MockDataFileName: String {
    case dessertMeals = "DessertMealsMockData"
    case dessertDetails = "DessertDetailsMockData"
}

/// This protocol is utilized to load mock data
protocol Mockable: AnyObject {
    func loadJson<T>(filename: MockDataFileName,
                                extensionType: FileExtensionType,
                                type: T.Type,
                                completion: @escaping (Result<T, Error>) -> Void)
    
    func loadJsonData(filename: MockDataFileName, extensionType: FileExtensionType) -> Data?
}

extension Mockable {
    
    func loadJson<T>(filename: MockDataFileName, extensionType: FileExtensionType, type: T.Type,  completion: @escaping (Result<T, Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: filename.rawValue, ofType: extensionType.rawValue) else {
            fatalError("Failed to load Json file.")
        }
        
        do {
            let data = try Data(contentsOf: URL(filePath: path))
            if let decodedObject = try JSONSerialization.jsonObject(with: data) as? T {
                completion(.success(decodedObject))
            }
            
        } catch {
            print("ERROR: \(error)")
            fatalError("Failed to decoded the Json.")
        }
    }
    
    func loadJsonData(filename: MockDataFileName, extensionType: FileExtensionType) -> Data? {
        guard let path = Bundle.main.path(forResource: filename.rawValue, ofType: extensionType.rawValue) else {
            fatalError("Failed to load Json file.")
        }
        
        do {
            let data = try Data(contentsOf: URL(filePath: path))
            return data
        } catch {
            print("ERROR: \(error)")
            fatalError("Failed to download Json data.")
        }
    }
}



