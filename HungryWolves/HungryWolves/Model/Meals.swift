//
//  Meals.swift
//  Test_API
//
//  Created by Andreea Lupașcu on 29.07.2022.
//

import Foundation

struct Meals: Decodable {
    let all: [Meal]
    
    enum CodingKeys: String, CodingKey {
        case all = "meals"
    }
}

