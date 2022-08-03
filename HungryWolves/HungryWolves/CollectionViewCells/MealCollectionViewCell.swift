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
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    func updateMealCell(with meal: Meal) {
        mealLabel.text = meal.name
            
        whiteBackground.sizeThatFits(CGSize(width: screenSize.width * 0.53 , height: screenSize.height * 0.30))
        whiteBackground.layer.cornerRadius = whiteBackground.frame.height / 8
        whiteBackground.layer.masksToBounds = false
        whiteBackground.layer.shadowColor = UIColor.gray.cgColor
        whiteBackground.layer.shadowOpacity = 0.2
        whiteBackground.layer.shadowOffset = CGSize(width: 0, height: 3)
        whiteBackground.layer.shadowRadius = 2
        whiteBackground.layer.shouldRasterize = true
        
        mealImageView.layer.cornerRadius = mealImageView.frame.height / 2
        mealImageView.layer.masksToBounds = true
        mealImageView.layer.shadowColor = UIColor.gray.cgColor
        mealImageView.layer.shadowOpacity = 0.2;
        mealImageView.layer.shadowOffset = CGSize(width: 0, height: 3)
        mealImageView.layer.shadowRadius = 2
        
        
        let url = URL(string: meal.imageURL)
        mealImageView.kf.setImage(with: url)
        
        if UIDevice.current.screenType == .iPhones_5_5s_5c_SE || UIDevice.current.screenType == .iPhones_6_6s_7_8 {
            mealLabel.font = mealLabel.font.withSize(17)
            mealImageView.sizeThatFits(CGSize(width: 100, height: 100))
        }
    }
}
