//
//  ResultsController.swift
//  ReceptApp
//
//  Created by Gavin Schipper on 17-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import Foundation

class ResultsController {
    
    static let shared = ResultsController()
    
    // Verzamelt de zoekresultaten van de API
    func fetchSearchResults(query: String, completion: @escaping (searchResults?) -> Void) {
        let url = URL(string: "https://food2fork.com/api/search?key=0bef0e09d13316b22b89a8b44b7e0666&q=\(query)")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let searchResults = try? jsonDecoder.decode(searchResults.self, from: data) {
                completion(searchResults)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    // Haalt een specifiek recept op van de API
    func fetchRecipeResult(query: [String], completion: @escaping (recipe?) -> Void) {
        let url = URL(string: "https://food2fork.com/api/get?key=0bef0e09d13316b22b89a8b44b7e0666&rId=\(query)")!
        let task = URLSession.shared.dataTask(with: url) { (data,
            response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let recipe = try? jsonDecoder.decode(recipe.self, from: data) {
                completion(recipe)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

}

