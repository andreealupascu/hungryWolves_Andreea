//
//  DetailViewModel.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 05.08.2022.
//

import Foundation
import UIKit
import Alamofire

protocol MealDetailViewModelDelegate: AnyObject {
    func detailReloadData()
    func tagsReloadData()
}

class MealDetailViewModel {
    
    weak var delegate: MealDetailViewModelDelegate?
    var detailsServer: [Detail] = []
    var detailServer: Detail?
    var tagsArray: [String] = []
    
    init() {
        self.fetchDetailMeal(idMeal: "")
    }
    
   private func fetchDetailMeal(idMeal: String) {
        AF.request(API.searchByIdAPI.rawValue + idMeal)
            .validate()
            .responseDecodable(of: Details.self) { (response) in
                switch(response.result) {
                case .success(_):
                    guard let details = response.value else { return }
                    self.detailsServer = details.all
                    self.detailServer = self.detailsServer[0]
                    self.tagsArray = self.detailServer?.tags.components(separatedBy: ",") ?? []
                    self.delegate?.detailReloadData()
                    self.delegate?.tagsReloadData()
                    break
                case .failure(_):
                    self.detailsServer = []
                    self.delegate?.detailReloadData()
                    self.delegate?.tagsReloadData()
                    break
                }
            }
    }
    
    func detailMeal(idMeal: String) {
        fetchDetailMeal(idMeal: idMeal)
    }
}

extension MealDetailsViewController: MealDetailViewModelDelegate {
    func detailReloadData() {
        self.viewDidLoad()
    }
    func tagsReloadData() {
        self.tagsCollectionView.reloadData()
    }
    
}

