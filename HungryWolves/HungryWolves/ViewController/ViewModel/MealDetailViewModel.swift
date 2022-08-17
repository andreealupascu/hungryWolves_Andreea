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
}

extension MealDetailsViewController: MealDetailViewModelDelegate {
    func detailReloadData() {
        self.viewDidLoad()
    }
    func tagsReloadData() {
        self.tagsCollectionView.reloadData()
    }
    func updateDetailMeal(with detail: Detail) {
        nameMealTextLabel.text = detail.name
        let dequeuedURL = self.mealDetailViewModel.detailServer?.imageURL
        guard let urlString = dequeuedURL else { return }
        let url = URL(string: urlString)
        let dequeuedURLYt = self.mealDetailViewModel.detailServer?.youtubeURL
        guard let urlYtString = dequeuedURLYt else { return }
        thumbnailFirstImageView.kf.setImage(with: url)
        let ytUrlString = "https://img.youtube.com/vi/" + saveIDYoutubeURL(url: urlYtString) + "/default.jpg"
        let ytUrl = URL(string: ytUrlString)
        thumbnailSecondImageView.kf.setImage(with: ytUrl)
        thumbnailSecondImageView.clipsToBounds = true
        measureFirstLabelText.text = detail.measureFirst
        measureSecondLabelText.text = detail.measureSecond
        measureThirdLabelText.text = detail.measureThird
        ingredientFirstLabelText.text = detail.ingredientFirst
        ingredientSecondLabelText.text = detail.ingredientSecond
        ingredientThirdLabelText.text = detail.ingredientThird
        instructionsLabelText.text = detail.instructions
        thumbnailFirstImageView.layer.cornerRadius = thumbnailFirstImageView.frame.width / 2
        thumbnailSecondImageView.layer.cornerRadius = thumbnailSecondImageView.frame.width / 2
    }
    
    func saveIDYoutubeURL(url: String) -> String {
        guard let index = url.range(of: "=")?.upperBound else { return "" }
        let substring = url.suffix(from: index)
        let string = String(substring)
        return string
    }
    
}


