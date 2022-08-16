//
//  FavoritesFileManager.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 10.08.2022.
//

import Foundation

struct FavouritesFileManager {
    
    static let archiveURL = FileManager.default.urls (
        for: .documentDirectory,
        in: .userDomainMask).first?.appendingPathComponent("favouritesMeals")
        .appendingPathExtension("plist")
    
    static func saveToFile(meal: [FavouriteMeal]) {
        guard let archiveURL = self.archiveURL else { return }
        let propertyListEncoder = PropertyListEncoder()
        let codedFavouritesMeals = try? propertyListEncoder.encode(meal)
        try? codedFavouritesMeals?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [FavouriteMeal] {
        guard let archiveURL = self.archiveURL,
              let codedFavouritesMeals = try? Data(contentsOf: archiveURL) else { return [] }
        let propertyListDecoder = PropertyListDecoder()
        return (try? propertyListDecoder.decode(Array<FavouriteMeal>.self, from: codedFavouritesMeals)) ?? []
    }
    
    static func saveToFile(meal: FavouriteMeal) {
        var meals = loadFromFile()
        meals.append(meal)
        saveToFile(meal: meals)
    }
}
