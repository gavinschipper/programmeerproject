//
//  Recipe.swift
//  ReceptApp
//
//  Created by Gavin Schipper on 17-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import Foundation

struct searchResult: Codable {
    var publisher: String
    var f2fURL: String
    var title: String
    var sourceURL: String
    var recipeID: String
    var imageURL: String
    var socialRank: Double
    var publisherURL: String
    
    enum CodingKeys: String, CodingKey {
        case publisher
        case f2fURL = "f2f_url"
        case title
        case sourceURL = "source_url"
        case recipeID = "recipe_id"
        case imageURL = "image_url"
        case socialRank = "social_rank"
        case publisherURL = "publisher_url"
    }
}

struct searchResults: Codable {
    let recipes: [searchResult]
}
