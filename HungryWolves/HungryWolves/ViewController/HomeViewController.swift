//
//  ViewController.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 30.07.2022.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftUI

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var mealCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var layoutMeal: UICollectionViewLayout?
    var layoutCategory: UICollectionViewLayout?
    var isFirstLoad: Bool = true
    let screenSize: CGRect = UIScreen.main.bounds
    let homeViewModel = HomeViewModel()
    var mealDetailCollectionView = MealDetailsViewController()
    let indexPos = IndexPath(row: 0, section: 0)
    var loadingIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoading()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
    
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue) {
        
    }
    
    func setupLoading() {
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        loadingIndicator.hidesWhenStopped = true
    }
}

extension HomeViewController {
    
    func mealLayoutGenerate() -> UICollectionViewLayout {
        
        let padding: CGFloat = 10
        var heightScreenPercent = 0.35
        var widthScreenPercent = 0.53
        
        if screenSize.width <= 400 {
            heightScreenPercent = 0.4
            widthScreenPercent = 0.54
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
                self.homeViewModel.categorySelected(categoryType: cell.categoryLabelText.text ?? "" )
            }
        }
        if collectionView == mealCollectionView {
            print(self.homeViewModel.mealsServer[indexPath.item].id)
            performSegue(withIdentifier: "idDetailsSegue", sender:
                            self.homeViewModel.mealsServer[indexPath.item].id)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "idDetailsSegue" {
            let destination = segue.destination as! MealDetailsViewController
            destination.mealID = sender as? String ?? ""
        }
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func mealReloadData() {
        self.mealCollectionView.reloadData()
        loadingIndicator.stopAnimating()
    }
    
    func categoryReloadData() {
        self.categoryCollectionView.reloadData()
        categoryCollectionView.selectItem(at: indexPos, animated: false, scrollPosition: [])
        loadingIndicator.stopAnimating()
    }
}
