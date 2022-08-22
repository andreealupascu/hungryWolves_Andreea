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
    func updateDetailMeal(with detail: Detail)
}

class MealDetailViewModel {
    
    weak var delegate: MealDetailViewModelDelegate?
    var detailsServer: [Detail] = []
    var detailServer: Detail?
    var tagsArray: [String] = []
    
    init() {
        self.fetchDetailMeal(idMeal: "")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadMealScreen(_:)),
                                               name: .mealDetailsScreen, object: nil)
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
                    if ((self.detailServer?.tags) != nil) {
                        let dequeuedDetailServer = self.detailServer?.tags
                        guard let tagsArray = dequeuedDetailServer else { return }
                        self.tagsArray = tagsArray.components(separatedBy: ",")
                    }
                    self.delegate?.detailReloadData()
                    self.delegate?.tagsReloadData()
                    guard let details = self.detailServer else { return }
                    self.delegate?.updateDetailMeal(with: details)
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
    
    @objc func reloadMealScreen(_ notification: Notification) {
        fetchDetailMeal(idMeal: "")
    }
    
    deinit {
        Foundation.NotificationCenter.default.removeObserver(self,
                                                             name: .searchScreen, object: nil)
    }
}
