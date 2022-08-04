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
    
    func updateSearchCell() {
        searchTextLabel.text = "Veggie tomato mix"
        searchImage.layer.cornerRadius = 70
        /*let url = URL(string: meal.imageURL)
        searchImage.kf.setImage(with: url)*/
        
    }
}


