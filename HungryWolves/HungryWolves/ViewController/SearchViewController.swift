//
//  SearchViewController.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 01.08.2022.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var searchCollectionView: UICollectionView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var foundMealsLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var itemNotFoundView: UIView!
    
    @IBAction func searchTextFieldAction(_ sender: UITextField) {
        self.searchViewModel.searchMeal(searchType: searchTextField.text ?? "")
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    var layoutSearch: UICollectionViewLayout?
    let screenSize: CGRect = UIScreen.main.bounds
    let searchViewModel = SearchViewModel()
    var isSearchNull = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.layer.cornerRadius = backgroundImageView.frame.height / 25
        layoutSearch = searchGenerateGridLayout()
        if let layout = layoutSearch {
            searchCollectionView.collectionViewLayout = layout
        }
        self.searchViewModel.delegate = self
        self.searchViewModel.searchMeal(searchType: searchTextField.text ?? "")
    }
}

extension SearchViewController {
    
    func searchGenerateGridLayout() -> UICollectionViewLayout {
        let padding: CGFloat = 20
        var setWidthPercent = 2.4
        
        if screenSize.width <= 400 {
            setWidthPercent = 2.2
        }
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(156 * setWidthPercent),
                heightDimension: .absolute(212)
            ),
            subitem: item,
            count: 2
        )
        group.interItemSpacing = .fixed(padding)
        
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: padding,
            bottom: 0,
            trailing: padding
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = padding
        section.contentInsets = NSDirectionalEdgeInsets(
            top: padding,
            leading: 0,
            bottom: padding,
            trailing: 0
        )
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.searchViewModel.mealsSearch.count == 0 {
            foundMealsLabel.text = ""
            itemNotFoundView.layer.opacity = 1.0
        }
        return self.searchViewModel.mealsSearch.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCollectionViewCell
        let meal = self.searchViewModel.mealsSearch[indexPath.item]
        cell.updateSearchCell(with: meal)
        cell.layer.cornerRadius = cell.frame.height / 8
        itemNotFoundView.layer.opacity = 0.0
        if searchTextField.text == "" {
            foundMealsLabel.text = ""
        } else {
            foundMealsLabel.text = "Found \(self.searchViewModel.mealsSearch.count) results"
        }
        return cell
    }
}
