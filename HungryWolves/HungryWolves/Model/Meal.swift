//
//  Food.swift
//  Test_API
//
//  Created by Andreea Lupașcu on 29.07.2022.
//

import Foundation

struct Meal: Decodable {
    var id: String
    var name: String
    var imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case imageURL = "strMealThumb"
    }
}

extension Meal: Displayable {
    
    var idLabelText: String {
        id
    }
    
    var nameLabelText: (label: String, value: String) {
        ("Name", name)
    }
    
    var imageURLLabelText: (label: String, value: String) {
        ("ImgURL", imageURL)
    }
}
