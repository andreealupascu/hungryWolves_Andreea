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
        var indexMealR = -1
        var indexMealBuffR = 0
        favoritesViewModel.loadFavouriteMeal()
        for index in favoritesViewModel.meals{
            if index.id == mealID {
                indexMealR = indexMealBuffR
            }
            indexMealBuffR = indexMealBuffR + 1
        }
                
        if isFavourite == false
        {
            favoriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
            favoritesViewModel.saveFavouriteMeal(id: mealDetailViewModel.detailServer?.id ?? "",
                                                 name: mealDetailViewModel.detailServer?.name ?? "",
                                                 imgURL: mealDetailViewModel.detailServer?.imageURL ?? "")
            indexMealR = indexMealBuffR
            indexMealBuffR = indexMealBuffR + 1
            isFavourite = true
        } else {
            favoriteButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
            favoritesViewModel.removeFavouriteMeal(at: indexMealR)
            indexMealBuffR = indexMealBuffR - 1
            indexMealR = indexMealR - 1
            FavouritesFileManager.saveToFile(meal: self.favoritesViewModel.meals)
            isFavourite = false
        }
       
    }
    
    let mealDetailViewModel = MealDetailViewModel()
    let homeDetailViewModel = HomeViewModel()
    let favoritesViewModel = FavouritesViewModel()
    var layoutTags: UICollectionViewLayout?
    var isFirstLoad: Bool = true
    var mealID = ""
    var isFavourite: Bool = false
    var loadingIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        loadingIndicator.hidesWhenStopped = true
        imageScrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.mealDetailViewModel.delegate = self
        if mealID != "" && isFirstLoad == true {
            self.mealDetailViewModel.detailMeal(idMeal: mealID)
            for index in favoritesViewModel.meals{
                if index.id == mealID {
                    favoriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                    isFavourite = true
                }
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

extension MealDetailsViewController: MealDetailViewModelDelegate {
    func detailReloadData() {
        self.viewDidLoad()
        loadingIndicator.stopAnimating()
    }
    func tagsReloadData() {
        self.tagsCollectionView.reloadData()
        loadingIndicator.stopAnimating()
    }
    func updateDetailMeal(with detail: Detail) {
        nameMealTextLabel.text = detail.name
        let dequeuedURL = self.mealDetailViewModel.detailServer?.imageURL
        guard let urlString = dequeuedURL else { return }
        let url = URL(string: urlString)
        let dequeuedURLYt = self.mealDetailViewModel.detailServer?.youtubeURL
        guard let urlYtString = dequeuedURLYt else { return }
        thumbnailFirstImageView.kf.setImage(with: url)
        let ytUrlString = "https://img.youtube.com/vi/" + saveIDYoutubeURL(url: urlYtString) + "/default.jpg"
        let ytUrl = URL(string: ytUrlString)
        thumbnailSecondImageView.kf.setImage(with: ytUrl)
        thumbnailSecondImageView.clipsToBounds = true
        thumbnailFirstImageView.layer.cornerRadius = thumbnailFirstImageView.frame.width / 2
        thumbnailSecondImageView.layer.cornerRadius = thumbnailSecondImageView.frame.width / 2
        thumbnailFirstImageView.layer.borderColor = UIColor(named: "Border")?.cgColor
        thumbnailFirstImageView.layer.borderWidth = 2
        thumbnailSecondImageView.layer.borderColor = UIColor(named: "Border")?.cgColor
        thumbnailSecondImageView.layer.borderWidth = 2
        measureFirstLabelText.text = detail.measureFirst
        measureSecondLabelText.text = detail.measureSecond
        measureThirdLabelText.text = detail.measureThird
        ingredientFirstLabelText.text = detail.ingredientFirst
        ingredientSecondLabelText.text = detail.ingredientSecond
        ingredientThirdLabelText.text = detail.ingredientThird
        instructionsLabelText.text = detail.instructions
        
    }

    func saveIDYoutubeURL(url: String) -> String {
        guard let index = url.range(of: "=")?.upperBound else { return "" }
        let substring = url.suffix(from: index)
        let string = String(substring)
        print(string)
        return string
    }
    
}
