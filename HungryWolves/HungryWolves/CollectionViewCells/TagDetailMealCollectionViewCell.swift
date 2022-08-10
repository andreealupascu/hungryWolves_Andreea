//
//  TagDetailMealCollectionViewCell.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 08.08.2022.
//

import UIKit

class TagDetailMealCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var tagLabelText: UILabel!
    @IBOutlet weak var tagCollectionViewCell: UIView!
    
    func updateTagsCell(with tag: String) {
        tagLabelText.text = tag
        tagLabelText.textColor = UIColor(red: 250, green: 74, blue: 12, a: 1)
        tagCollectionViewCell.layer.cornerRadius = tagLabelText.frame.height / 1.25;   tagCollectionViewCell.layer.borderWidth = 1
        tagCollectionViewCell.layer.borderColor = UIColor(red: 250, green: 74, blue: 12, a: 1).cgColor
    }
}
