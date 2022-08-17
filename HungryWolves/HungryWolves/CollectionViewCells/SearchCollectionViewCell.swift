//
//  SearchCollectionViewCell.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 01.08.2022.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var searchTextLabel: UILabel!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var searchContentView: UIView!
    let screenSize: CGRect = UIScreen.main.bounds
    
    func updateSearchCell(with meal: Meal) {
        searchTextLabel.text = meal.name
        searchImage.layer.cornerRadius = searchImage.frame.width / 2
        searchImage.layer.masksToBounds = true
        searchImage.layer.shadowColor = UIColor.gray.cgColor
        searchImage.layer.shadowOpacity = 0.2;
        searchImage.layer.shadowOffset = CGSize(width: 0, height: 3)
        searchImage.layer.shadowRadius = 2
        if screenSize.width <= 400
        {
            searchImage.translatesAutoresizingMaskIntoConstraints = false
            searchImage.heightAnchor.constraint(equalToConstant: 130).isActive = true
            searchImage.widthAnchor.constraint(equalToConstant: 130).isActive = true
        }
        let url = URL(string: meal.imageURL)
        searchImage.kf.setImage(with: url)
    }
}


