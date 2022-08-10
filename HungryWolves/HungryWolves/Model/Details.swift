//
//  Details.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 05.08.2022.
//

import Foundation

struct Details: Decodable {
    let all: [Detail]
    
    enum CodingKeys: String, CodingKey {
        case all = "meals"
    }
}

