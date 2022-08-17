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
        cellBackgroundView.layer.cornerRadius = cellBackgroundView.frame.height / 4
    }
    

}
