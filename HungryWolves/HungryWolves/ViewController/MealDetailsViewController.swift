//
//  MealDetailsViewController.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 05.08.2022.
//

import UIKit
import Kingfisher
import AVFoundation

class MealDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate  {
    
    @IBOutlet var mealDetailsView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var checkIngredientButton: UIButton!
    @IBOutlet weak var checkIngredientButton2: UIButton!
    @IBOutlet weak var checkIngredientButton3: UIButton!
    @IBOutlet weak var thumbnailFirstImageView: UIImageView!
    @IBOutlet weak var thumbnailSecondImageView: UIImageView!
    @IBOutlet weak var nameMealTextLabel: UILabel!
    @IBOutlet weak var measureFirstLabelText: UILabel!
    @IBOutlet weak var measureSecondLabelText: UILabel!
    @IBOutlet weak var measureThirdLabelText: UILabel!
    @IBOutlet weak var ingredientFirstLabelText: UILabel!
    @IBOutlet weak var ingredientSecondLabelText: UILabel!
    @IBOutlet weak var ingredientThirdLabelText: UILabel!
    @IBOutlet weak var instructionsLabelText: UILabel!
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    @IBOutlet weak var imagePageControl: UIPageControl!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func checkIngredientButtonTapped(_ sender: UIButton) {
        checkIngredientButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
    }
    @IBAction func checkIngredientsButton2Tapped(_ sender: UIButton) {
        checkIngredientButton2.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
    }
    
    @IBAction func checkIngredientButton3Tapped(_ sender: UIButton) {
        checkIngredientButton3.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
    }
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        favoriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
    }
    
    let mealDetailViewModel = MealDetailViewModel()
    let homeDetailViewModel = HomeViewModel()
    var layoutTags: UICollectionViewLayout?
    var isFirstLoad: Bool = true
    var mealID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageScrollView.delegate = self
        thumbnailFirstImageView.layer.cornerRadius = thumbnailFirstImageView.frame.width / 2
        thumbnailSecondImageView.layer.cornerRadius = thumbnailSecondImageView.frame.width / 2        
        let detailsMeal = self.mealDetailViewModel.detailServer
        updateDetailMeal(with: detailsMeal)
        self.mealDetailViewModel.delegate = self
        if mealID != "" && isFirstLoad == true {
            self.mealDetailViewModel.detailMeal(idMeal: mealID)
            isFirstLoad = false
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pageIndex = round(imageScrollView.contentOffset.x/view.frame.width)
            imagePageControl.currentPage = Int(pageIndex)
        }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mealDetailViewModel.tagsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tagCell = tagsCollectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagDetailMealCollectionViewCell
        tagCell.layer.cornerRadius = 10
        tagCell.updateTagsCell(with: self.mealDetailViewModel.tagsArray[indexPath.item])
        tagCell.layer.cornerRadius = 15
        tagCell.layer.borderWidth = 1
        tagCell.layer.borderColor = UIColor(red: 250, green: 74, blue: 12, a: 1).cgColor
        return tagCell
    }
    
    func updateDetailMeal(with detail: Detail?) {
        nameMealTextLabel.text = detail?.name
        let url = URL(string: self.mealDetailViewModel.detailServer?.imageURL ?? "")
        thumbnailFirstImageView.kf.setImage(with: url)
        thumbnailSecondImageView.kf.setImage(with: url)
        measureFirstLabelText.text = detail?.measureFirst ?? ""
        measureSecondLabelText.text = detail?.measureSecond ?? ""
        measureThirdLabelText.text = detail?.measureThird ?? ""
        ingredientFirstLabelText.text = detail?.ingredientFirst ?? ""
        ingredientSecondLabelText.text = detail?.ingredientSecond ?? ""
        ingredientThirdLabelText.text = detail?.ingredientThird ?? ""
        instructionsLabelText.text = detail?.instructions ?? ""
    }
}
