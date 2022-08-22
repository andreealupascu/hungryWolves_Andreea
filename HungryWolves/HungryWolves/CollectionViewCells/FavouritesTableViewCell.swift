//
//  FavoritesTableViewCell.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 10.08.2022.
//

import UIKit
import Kingfisher

class FavouritesTableViewCell: UITableViewCell {
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
    
    func updateFavouritesCell(with meal: FavouriteMeal)
    {
        mealNameLabel.text = meal.name
        let url = URL(string: meal.imageURL)
        mealImageView.kf.setImage(with: url)
        mealImageView.layer.cornerRadius = mealImageView.frame.width / 2
        mealImageView.layer.borderWidth = 2
        mealImageView.layer.borderColor = UIColor(named: "Border")?.cgColor
        
        cellBackgroundView.layer.cornerRadius = cellBackgroundView.frame.height / 4
        cellBackgroundView.layer.masksToBounds = false
        cellBackgroundView.layer.shadowColor = UIColor.gray.cgColor
        cellBackgroundView.layer.shadowOpacity = 0.2
        cellBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        cellBackgroundView.layer.shadowRadius = 2
        cellBackgroundView.layer.shouldRasterize = true
    }
    

}
