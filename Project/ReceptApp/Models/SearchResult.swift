//
//  Recipe.swift
//  ReceptApp
//
//  Created by Gavin Schipper on 17-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import Foundation

struct searchResult: Codable {
    var title: String
    var sourceURL: String
    var recipeID: String
    var imageURL: String

    
    enum CodingKeys: String, CodingKey {
        case title
        case sourceURL = "source_url"
        case recipeID = "recipe_id"
        case imageURL = "image_url"
    }
}

struct searchResults: Codable {
    let recipes: [searchResult]
}
