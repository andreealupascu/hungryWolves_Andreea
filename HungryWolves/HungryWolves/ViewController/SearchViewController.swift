//
//  SearchViewController.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 01.08.2022.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    var layoutSearch: UICollectionViewLayout?
    let screenSize: CGRect = UIScreen.main.bounds

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutSearch = searchGenerateGridLayout()
        if let layout = layoutSearch {
            searchCollectionView.collectionViewLayout = layout
        }
    }
    
}

extension SearchViewController {
    
    func searchGenerateGridLayout() -> UICollectionViewLayout {
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
            count: 2
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
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCollectionViewCell
        
        cell.updateSearchCell()
        cell.layer.cornerRadius = cell.frame.height / 6
        return cell
    }
    
}
