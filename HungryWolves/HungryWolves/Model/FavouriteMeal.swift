//
//  FavoriteMeal.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 10.08.2022.
//

import Foundation

class FavouriteMeal: Codable {
    var id: String
    var name: String
    var imageURL: String
    
    init(id: String, name: String, imageURL: String) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
    }
}
