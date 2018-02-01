//
//  Recipe.swift
//  ReceptApp
//
//  Created by Gavin Schipper on 17-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import Foundation

struct recipe: Codable {
    var ingredients: [String]
    var sourceURL: String
    var recipeID: String
    var imageURL: String
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case ingredients
        case sourceURL = "source_url"
        case recipeID = "recipe_id"
        case imageURL = "image_url"
        case title
    }
}

struct searchedRecipe: Codable {
    let recipe: recipe
}
