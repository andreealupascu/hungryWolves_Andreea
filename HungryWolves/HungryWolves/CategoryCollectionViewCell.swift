//
//  CategoryCollectionViewCell.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 31.07.2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryButton: UIButton!
    func updateCategoriesCell(with category: Category) {
        categoryButton.titleLabel?.text = category.name
        //categoryButton.frame.size.width = (categoryButton.titleLabel?.frame.size.width)!
       // categoryButton.titleLabel?.textColor = UIColor.black
        categoryButton.sizeToFit()
    }
}
