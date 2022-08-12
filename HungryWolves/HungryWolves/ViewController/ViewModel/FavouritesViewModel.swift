//
//  FavoritesViewModel.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 10.08.2022.
//

import Foundation
import UIKit

class FavouritesViewModel {
    
    var meals: [FavouriteMeal] = []
    
    init() {
        self.loadFavouriteMeal()
    }
    
    func removeFavouriteMeal(at index: Int) {
        self.meals.remove(at: index)
    }
    
    var meal: FavouriteMeal?
    
    init(existingFavouriteMeal: FavouriteMeal? = nil) {
        self.meal = existingFavouriteMeal
    }
    
    func loadFavouriteMeal() {
        self.meals = FavouritesFileManager.loadFromFile()
    }
    
    func saveFavouriteMeal(id: String, name: String, imgURL: String) {
            let newMeal = FavouriteMeal(id: id, name: name, imageURL: imgURL)
        print("fav meal", newMeal.id, newMeal.name)
            FavouritesFileManager.saveToFile(meal: newMeal)
        }
}


