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
    
    override var isSelected: Bool {
        didSet {
            categoryLabelText.textColor = isSelected ? UIColor(red: 250, green: 74, blue: 12, a: 1) : UIColor(red: 154, green: 154, blue: 157, a: 1)
            lineImageView.backgroundColor = isSelected ? UIColor(red: 250, green: 74, blue: 12, a: 1) : UIColor(red: 229, green: 229, blue: 229, a: 1)
        }
    }

}
