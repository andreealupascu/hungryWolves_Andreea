//
//  MealCollectionViewCell.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 31.07.2022.
//

import UIKit
import Kingfisher

class MealCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var whiteBackground: UIImageView!
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealLabel: UILabel!
    func updateMealCell(with meal: Meal) {
        mealLabel.text = meal.name
        whiteBackground.layer.cornerRadius = whiteBackground.frame.height / 8
        mealImageView.layer.cornerRadius = mealImageView.frame.height / 2
        
        let url = URL(string: meal.imageURL)
        mealImageView.kf.setImage(with: url)
        
    }
}
