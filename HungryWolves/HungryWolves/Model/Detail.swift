//
//  Detail.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 05.08.2022.
//

import Foundation

struct Detail: Decodable {
    let id: String
    let name: String
    let imageURL: String
    let youtubeURL: String
    let instructions: String
    let tags: String
    let ingredientFirst: String
    let ingredientSecond: String
    let ingredientThird: String
    let measureFirst: String
    let measureSecond: String
    let measureThird: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case imageURL = "strMealThumb"
        case youtubeURL = "strYoutube"
        case instructions = "strInstructions"
        case tags = "strTags"
        case ingredientFirst = "strIngredient1"
        case ingredientSecond = "strIngredient2"
        case ingredientThird = "strIngredient3"
        case measureFirst = "strMeasure1"
        case measureSecond = "strMeasure2"
        case measureThird = "strMeasure3"
    }
}

extension Detail:  DiplaybleDetails {
    var idMealLabelText: String {
        id
    }
    
    var youtubeURLLabelText: (label: String, value: String) {
        ("YoutubeURL", youtubeURL)
    }
    
    var instructionsLabelText: (label: String, value: String) {
        ("Instructions", instructions)
    }
    
    var tagsLabelText: (label: String, value: String) {
        ("Tags", tags)
    }
    
    var ingredient1LabelText: (label: String, value: String) {
        ("Ingredient 1", ingredientFirst)
    }
    
    var ingredient2LabelText: (label: String, value: String) {
        ("Ingredient 2", ingredientSecond)
    }
    
    var ingredient3LabelText: (label: String, value: String) {
        ("Ingredient 3", ingredientThird)
    }
    
    var measure1LabelText: (label: String, value: String) {
        ("Measure 1", measureFirst)
    }
    
    var measure2LabelText: (label: String, value: String) {
        ("Measure 2", measureSecond)
    }
    
    var measure3LabelText: (label: String, value: String) {
        ("Measure 3", measureThird)
    }
    
    
    var nameLabelText: (label: String, value: String) {
        ("Name", name)
    }
    
    var imageURLLabelText: (label: String, value: String) {
        ("ImgURL", imageURL)
    }
}
