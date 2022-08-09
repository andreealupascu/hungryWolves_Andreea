//
//  ProfileViewController.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 09.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var favoritesView: UIView!
    @IBOutlet weak var profileInfoView: UIView!
    
    @IBOutlet weak var termsAndCondtionsView: UIView!
    
    @IBAction func termsAndConditionButtonTapped(_ sender: Any) {
        guard let url = URL(string: "https://www.wolfpack-digital.com/privacy") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func favoritesButtonTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
    }
    
    var profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
