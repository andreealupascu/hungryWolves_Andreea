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
        if isFavourite == false
        {
            favoriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
            favoritesViewModel.saveFavouriteMeal(id: mealDetailViewModel.detailServer?.id ?? "",
                                                 name: mealDetailViewModel.detailServer?.name ?? "",
                                                 imgURL: mealDetailViewModel.detailServer?.imageURL ?? "")
        } else {
            favoriteButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
            favoritesViewModel.removeFavouriteMeal(at: indexMeal)
            FavouritesFileManager.saveToFile(meal: self.favoritesViewModel.meals)
        }
       
    }
    
    let mealDetailViewModel = MealDetailViewModel()
    let homeDetailViewModel = HomeViewModel()
    let favoritesViewModel = FavouritesViewModel()
    var layoutTags: UICollectionViewLayout?
    var isFirstLoad: Bool = true
    var mealID = ""
    var isFavourite: Bool = false
    var indexMeal: Int = -1
    var indexMealBuff = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageScrollView.delegate = self
        self.mealDetailViewModel.delegate = self
        if mealID != "" && isFirstLoad == true {
            self.mealDetailViewModel.detailMeal(idMeal: mealID)
            for index in favoritesViewModel.meals{
                if index.id == mealID {
                    favoriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                    isFavourite = true
                    indexMeal = indexMealBuff
                }
                indexMealBuff = indexMealBuff + 1
            }
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
        tagCell.updateTagsCell(with: self.mealDetailViewModel.tagsArray[indexPath.item])
        return tagCell
    }
    
}

