//
//  Category.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 31.07.2022.
//

import Foundation

struct Category: Decodable {
    let id: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
    }
}

extension Category: DisplaybleCategories {
    
    var idCategoryText: String {
        id
    }
    
    var nameCategoryLabelText: (label: String, value: String) {
        ("Name", name)
    }
}
