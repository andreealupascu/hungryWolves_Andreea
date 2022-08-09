//
//  TagDetailMealCollectionViewCell.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 08.08.2022.
//

import UIKit

class TagDetailMealCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var tagLabelText: UILabel!
    func updateTagsCell(with tag: String) {
        tagLabelText.text = tag
        tagLabelText.textColor = UIColor(red: 250, green: 74, blue: 12, a: 1)
    }
    
}
