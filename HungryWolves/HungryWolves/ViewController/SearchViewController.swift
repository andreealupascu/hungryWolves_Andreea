//
//  SearchViewController.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 01.08.2022.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var searchCollectionView: UICollectionView!
    @IBOutlet weak var foundMealsLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var itemNotFoundView: UIView!
    
    @IBAction func searchTextFieldAction(_ sender: UITextField) {
        self.searchViewModel.searchMeal(searchType: searchTextField.text ?? "")
    }
    
    @IBAction func backButton(_ sender: UIButton) {
    }
    
    var layoutSearch: UICollectionViewLayout?
    let screenSize: CGRect = UIScreen.main.bounds
    let searchViewModel = SearchViewModel()
    var isSearchNull = true
    var loadingIndicator = UIActivityIndicatorView(style: .large)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemNotFoundView.layer.opacity = 0.0
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        loadingIndicator.hidesWhenStopped = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        itemNotFoundView.layer.opacity = 0.0
        foundMealsLabel.layer.masksToBounds = true
        foundMealsLabel.layer.cornerRadius = 20
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
        var paddingPercent = 1.8
        if screenSize.width <= 400 {
            setWidthPercent = 2.2
            paddingPercent = 1.4
        }
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.1),
                heightDimension: .fractionalHeight(1)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(150 * setWidthPercent),
                heightDimension: .absolute(212)
            ),
            subitem: item,
            count: 2
        )
        group.interItemSpacing = .fixed(padding)
        
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: padding
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = padding
        section.contentInsets = NSDirectionalEdgeInsets(
            top: padding,
            leading: padding * paddingPercent,
            bottom: padding,
            trailing: 0
        )
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.searchViewModel.mealsSearch.count == 0 {
            foundMealsLabel.text = ""
            itemNotFoundView.layer.opacity = 1.0
        } else {
            itemNotFoundView.layer.opacity = 0.0
        }
        return self.searchViewModel.mealsSearch.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCollectionViewCell
        let meal = self.searchViewModel.mealsSearch[indexPath.item]
        cell.updateSearchCell(with: meal)
        cell.layer.cornerRadius = cell.frame.height / 8
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowOffset = CGSize(width: 0, height: 3)
        cell.layer.shadowRadius = 2
        cell.layer.shouldRasterize = true
        itemNotFoundView.layer.opacity = 0.0
        if searchTextField.text == "" {
            foundMealsLabel.text = "Try to find something"
        } else {
            foundMealsLabel.text = "Found \(self.searchViewModel.mealsSearch.count) results"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "idDetailsSegue2", sender: self.searchViewModel.mealsSearch[indexPath.item].id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "idDetailsSegue2" {
            let destination = segue.destination as! MealDetailsViewController
            destination.mealID = sender as? String ?? ""
            print(destination.mealID)
        }
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func searchReloadData() {
        self.searchCollectionView.reloadData()
        loadingIndicator.stopAnimating()
    }
}
