//
//  CategoryCollectionViewCell.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 31.07.2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryLabelText: UILabel!
    @IBOutlet weak var lineImageView: UIImageView!
    
    func updateCategoriesCell(with category: Category) {
        categoryLabelText.text = category.name
        lineImageView.layer.cornerRadius = 2
    }
}
