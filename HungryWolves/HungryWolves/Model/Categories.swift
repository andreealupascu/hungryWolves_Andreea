//
//  Categories.swift
//  Test_API
//
//  Created by Andreea Lupașcu on 29.07.2022.
//

import Foundation

struct Categories: Decodable {
    let all: [Category]
    
    enum CodingKeys: String, CodingKey {
        case all = "categories"
    }
}
