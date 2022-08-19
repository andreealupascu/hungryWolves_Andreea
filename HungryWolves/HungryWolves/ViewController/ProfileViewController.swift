//
//  ProfileViewController.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 09.08.2022.
//

import UIKit
import WebKit

class ProfileViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var favoritesView: UIView!
    @IBOutlet weak var profileInfoView: UIView!
    @IBOutlet weak var termsAndCondtionsView: UIView!
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var backButtonView: UIView!
    @IBAction func termsAndConditionButtonTapped(_ sender: Any) {
        let url = "https://www.wolfpack-digital.com/privacy"
        let urlRequest = URLRequest(url: URL(string: url)!)
        webView.load(urlRequest)
        webView.layer.opacity = 1.0
        backButtonView.layer.opacity = 1.0
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        webView.layer.opacity = 0.0
        backButtonView.layer.opacity = 0.0
    }
    
    @IBAction func favoritesButtonTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
    }
    
    
    var profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.layer.opacity = 0.0
        backButtonView.layer.opacity = 0.0
        favoritesView.layer.cornerRadius = 15
        profileInfoView.layer.cornerRadius = 15
        termsAndCondtionsView.layer.cornerRadius = 15
        let profileInfo = self.profileViewModel.profile
        updateProfileInfo(with: profileInfo)
        self.profileViewModel.delegate = self
    }
    
    func updateProfileInfo(with profile: Profile) {
        nameLabel.text = profile.name
        phoneLabel.text = profile.phone
        emailLabel.text = profile.email
    }

}

extension ProfileViewController: ProfileViewModelDelegate {
    func profileReloadData() {
        self.viewDidLoad()
    }
}
