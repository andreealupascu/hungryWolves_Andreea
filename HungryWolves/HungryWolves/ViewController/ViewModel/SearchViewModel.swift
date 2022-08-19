//
//  SearchViewModel.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 03.08.2022.
//

import Foundation
import UIKit
import Alamofire

protocol SearchViewModelDelegate: AnyObject {
    func searchReloadData()
}

class SearchViewModel {
    
    var mealsSearch: [Meal] = []
    weak var delegate: SearchViewModelDelegate?
    
    init() {
        self.fetchSearchMeal(searchType: "")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadSearchScreen(_:)),
                                               name: .searchScreen, object: nil)
    }
    
    private func fetchSearchMeal(searchType: String) {
        AF.request(API.searchByNameAPI.rawValue + searchType)
            .validate()
            .responseDecodable(of: Meals.self) { (response) in
                switch(response.result) {
                case .success(_):
                    guard let meals = response.value else { return }
                    self.mealsSearch = meals.all
                    self.delegate?.searchReloadData()
                    break
                case .failure(_):
                    self.mealsSearch = []
                    self.delegate?.searchReloadData()
                    break
                }
            }
    }
    
    func searchMeal(searchType: String) {
        fetchSearchMeal(searchType: searchType)
    }
    
    @objc func reloadSearchScreen(_ notification: Notification) {
       fetchSearchMeal(searchType: "")
    }
    
    deinit {
        Foundation.NotificationCenter.default.removeObserver(self,
                                                             name: .searchScreen, object: nil)
    }
}
