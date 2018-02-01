//
//  ResultsController.swift
//  ReceptApp
//
//  The ResultsController contains the functions that can be used to retrieve data from the API. They are shared functions so they can be called in every file.
//
//  Created by Gavin Schipper on 17-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import Foundation

class ResultsController {
    
    static let shared = ResultsController()
    
    /// Searches for recipes using a query containing the ingredients that were given in the searchViewController
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
    
    /// Retrieves a specific recipe from the API using the recipeID
    func fetchRecipeResult(query: String, completion: @escaping (searchedRecipe?) -> Void) {
        let url = URL(string: "https://food2fork.com/api/get?key=0bef0e09d13316b22b89a8b44b7e0666&rId=\(query)")!
        let task = URLSession.shared.dataTask(with: url) { (data,
            response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let searchedRecipe = try? jsonDecoder.decode(searchedRecipe.self, from: data) {
                completion(searchedRecipe)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}

