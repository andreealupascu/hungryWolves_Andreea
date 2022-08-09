//
//  Constants.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 04.08.2022.
//

import Foundation

enum API: String {
    case filterAPI = "https://www.themealdb.com/api/json/v1/1/filter.php?c="
    case categoriesAPI = "https://www.themealdb.com/api/json/v1/1/categories.php"
    case searchByNameAPI = "https://www.themealdb.com/api/json/v1/1/search.php?s="
    case searchByIdAPI = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
}

