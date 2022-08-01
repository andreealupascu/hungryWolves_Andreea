//
//  Food.swift
//  Test_API
//
//  Created by Andreea Lupașcu on 29.07.2022.
//

import Foundation

struct Meal: Decodable {
    let id: String
    let name: String
    let imageURL: String
    
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
