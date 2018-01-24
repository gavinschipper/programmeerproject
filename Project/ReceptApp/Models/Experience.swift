//
//  Experience.swift
//  ReceptApp
//
//  Created by Gavin Schipper on 24-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import Foundation
import Firebase

let ref: DatabaseReference! = Database.database().reference()

struct experience: Codable {
    var experienceText: String
    var userID: String
    var username: String
}
