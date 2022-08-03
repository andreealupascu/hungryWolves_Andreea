//
//  ViewController.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 30.07.2022.
//

import UIKit
import Alamofire
import Kingfisher

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var mealCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var layoutMeal: UICollectionViewLayout?
    var layoutCategory: UICollectionViewLayout?
    var isFirstLoad: Bool = true
    let screenSize: CGRect = UIScreen.main.bounds
    let homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutMeal = mealLayoutGenerate()
        if let layout = layoutMeal {
            mealCollectionView.collectionViewLayout = layout
        }
        layoutCategory = categoriesLayoutGenerate()
        if let layout = layoutCategory {
            categoryCollectionView.collectionViewLayout = layout
        }
        self.homeViewModel.delegate = self
        
    }
}

extension HomeViewController {
    
    func mealLayoutGenerate() -> UICollectionViewLayout {
        
        let padding: CGFloat = 10
        var heightScreenPercent = 0.35
        var widthScreenPercent = 0.53
        
        if screenSize.width <= 400 {
            heightScreenPercent = 0.40
            widthScreenPercent = 0.50
        }
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(widthScreenPercent * self.screenSize.width),
                heightDimension: .absolute(heightScreenPercent * self.screenSize.height)
            ),
            subitem: item,
            count: 1
        )
        group.interItemSpacing = .fixed(padding)
        
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: padding,
            bottom: padding,
            trailing: 0
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = padding
        section.contentInsets = NSDirectionalEdgeInsets(
            top: padding,
            leading: 0,
            bottom: padding,
            trailing: 0
        )
        section.orthogonalScrollingBehavior = .groupPaging
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func categoriesLayoutGenerate() -> UICollectionViewLayout {
        let padding: CGFloat = 10
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(120),
                heightDimension: .absolute(50)
            ),
            subitem: item,
            count: 1
        )
        group.interItemSpacing = .fixed(padding)
        
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: padding,
            bottom: padding,
            trailing: 0
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = padding
        section.contentInsets = NSDirectionalEdgeInsets(
            top: padding,
            leading: 0,
            bottom: padding,
            trailing: 0
        )
        section.orthogonalScrollingBehavior = .groupPaging
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.homeViewModel.mealsServer.count, self.homeViewModel.categoriesServer.count)
        if collectionView == categoryCollectionView {
            return self.homeViewModel.categoriesServer.count
        } else if collectionView == mealCollectionView {
            return self.homeViewModel.mealsServer.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let categoryCell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
            let category = self.homeViewModel.categoriesServer[indexPath.item]
            categoryCell.updateCategoriesCell(with: category)
            
            if indexPath.section == 0 && indexPath.row == 0 && isFirstLoad == true {
                categoryCell.categoryLabelText.textColor = UIColor(red: 250 / 255, green: 74 / 255, blue: 12 / 255, alpha: 1)
                categoryCell.lineImageView.backgroundColor = UIColor(red: 250 / 255, green: 74 / 255, blue: 12 / 255, alpha: 1)
                categoryCell.isSelected = true
                isFirstLoad = false
            } else {
                categoryCell.categoryLabelText.textColor = UIColor(red: 154 / 255, green: 154 / 255, blue: 157 / 255, alpha: 1)
                categoryCell.lineImageView.backgroundColor  = UIColor(red: 229 / 255, green: 229 / 255, blue: 229 / 255, alpha: 1)
                categoryCell.isSelected = false
            }
            return categoryCell
            
        } else {
            let mealCell = mealCollectionView.dequeueReusableCell(withReuseIdentifier: "MealCell", for: indexPath) as! MealCollectionViewCell
            let meal = self.homeViewModel.mealsServer[indexPath.item]
            mealCell.updateMealCell(with: meal)
            return mealCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
                //cell.prepareForReuse()
                cell.categoryLabelText.textColor = UIColor(red: 250 / 255, green: 74 / 255, blue: 12 / 255, alpha: 1)
                cell.lineImageView.backgroundColor = UIColor(red: 250 / 255, green: 74 / 255, blue: 12 / 255, alpha: 1)
                
                self.homeViewModel.categorySelected(categoryType: cell.categoryLabelText.text ?? "" )
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
                cell.categoryLabelText.textColor = UIColor(red: 154 / 255, green: 154 / 255, blue: 157 / 255, alpha: 1)
                cell.lineImageView.backgroundColor  = UIColor(red: 229 / 255, green: 229 / 255, blue: 229 / 255, alpha: 1)
            }
        }
    }
    
}

extension UICollectionView {
    
    func deselectAllItems(animated: Bool) {
        guard let selectedItems = indexPathsForSelectedItems else { return }
        for indexPath in selectedItems { deselectItem(at: indexPath, animated: animated) }
    }
}
