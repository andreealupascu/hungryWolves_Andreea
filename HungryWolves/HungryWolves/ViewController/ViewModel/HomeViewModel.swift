//
//  HomeViewModel.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 02.08.2022.
//

import Foundation
import UIKit
import Alamofire

protocol HomeViewModelDelegate: AnyObject {
    func mealReloadData()
    func categoryReloadData()
}

class HomeViewModel {
    
    var mealsServer: [Meal] = []
    var categoriesServer: [Category] = []
    var isFirstLoad: Bool = true
    
    weak var delegate: HomeViewModelDelegate?
    
    init() {
        self.fetchCategories()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadHomeScreen(_:)),
                                               name: .homeScreenMeal, object: nil)
    }
    
    private func fetchMeal(categoryType: String) {
        AF.request(API.filterAPI.rawValue + categoryType)
            .validate()
            .responseDecodable(of: Meals.self) { (response) in
                guard let meals = response.value else { return }
                self.mealsServer = meals.all
                self.delegate?.mealReloadData()
            }
    }
    
    private func fetchCategories() {
        AF.request(API.categoriesAPI.rawValue)
            .validate()
            .responseDecodable(of: Categories.self) { (response) in
                guard let categories = response.value else { return }
                self.categoriesServer = categories.all
                self.delegate?.categoryReloadData()
                if self.isFirstLoad == true {
                    self.isFirstLoad = false
                    self.fetchMeal(categoryType: self.categoriesServer[0].name)
                }
            }
    }
    
    func categorySelected(categoryType: String) {
        
        fetchMeal(categoryType: categoryType)
        print(Notification.Name.homeScreenCategory)
    }
    
    @objc func reloadHomeScreen(_ notification: Notification) {
        fetchCategories()
        fetchMeal(categoryType: "")
    }
    
    deinit {
        Foundation.NotificationCenter.default.removeObserver(self,
                                                             name: .homeScreenMeal, object: nil) }
}

extension HomeViewController: HomeViewModelDelegate {
    func mealReloadData() {
        self.mealCollectionView.reloadData()
    }
    
    func categoryReloadData() {
        self.categoryCollectionView.reloadData()
    }
}
