//
//  ViewController.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 30.07.2022.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    @IBOutlet weak var mealCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var mealsServer: [Meal] = []
    var itemServer: [Displayable] = []
    var categoriesServer: [Category] = []
    var itemCategoryServer: [DisplaybleCategories] = []
    var layoutMeal: UICollectionViewLayout?
    var layoutCategory: UICollectionViewLayout?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFood()
        fetchCategory()
        layoutMeal = generateGridLayoutMeal()
        if let layout = layoutMeal {
            mealCollectionView.collectionViewLayout = layout
        }
        layoutCategory = generateGridLayoutCategory()
        if let layout = layoutCategory {
            categoryCollectionView.collectionViewLayout = layout
        }
    }
    
}

extension ViewController {
    
    func generateGridLayoutMeal() -> UICollectionViewLayout {
        let padding: CGFloat = 10
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(220), //.fractionalWidth(1),
                heightDimension: .absolute(310) //.fractionalHeight(1/4)
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
        section.orthogonalScrollingBehavior = .groupPaging //.groupPagingCentered
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(mealsServer.count, categoriesServer.count)
        if collectionView == categoryCollectionView {
            return categoriesServer.count
        } else {
            return mealsServer.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell2 = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
            let category = categoriesServer[indexPath.item]
            cell2.updateCategoriesCell(with: category)
            return cell2
        } else {
            let cell = mealCollectionView.dequeueReusableCell(withReuseIdentifier: "MealCell", for: indexPath) as! MealCollectionViewCell
            let meal = mealsServer[indexPath.item]
            cell.updateMealCell(with: meal)
            return cell
        }
    }
}

extension ViewController {
    
    func generateGridLayoutCategory() -> UICollectionViewLayout {
        let padding: CGFloat = 10
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(130),
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
}


extension ViewController {
    func fetchFood() {
        AF.request("https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood")
            .validate()
            .responseDecodable(of: Meals.self) { (response) in
                guard let meals = response.value else { return }
                self.mealsServer = meals.all
                self.itemServer = meals.all
                self.mealCollectionView.reloadData()
            }
    }
    
    func fetchCategory() {
        AF.request("https://www.themealdb.com/api/json/v1/1/categories.php")
            .validate()
            .responseDecodable(of: Categories.self) { (response) in
                guard let categories = response.value else { return }
                self.categoriesServer = categories.all
                self.itemCategoryServer = categories.all
                print(categories.all[0].name)
                print(self.itemCategoryServer.count)
                print(self.categoriesServer.count, self.categoriesServer[0].name, self.categoriesServer[0].id)
                self.categoryCollectionView.reloadData()
            }
    }
}
