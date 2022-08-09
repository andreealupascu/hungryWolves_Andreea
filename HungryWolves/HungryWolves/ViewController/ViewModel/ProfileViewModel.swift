//
//  ProfileViewModel.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 09.08.2022.
//

import Foundation
import UIKit

protocol ProfileViewModelDelegate: AnyObject {
    func profileReloadData()
}

class ProfileViewModel {
    
    var profile = Profile()
    weak var delegate: ProfileViewModelDelegate?
    
    init() {
        fetchProfile()
    }
    
    private func fetchProfile() {
        self.profile.name = "Andreea Lupașcu"
        self.profile.email = "andreeagabriela12@gmail.com"
        self.profile.phone = "+40 728 717 259"
        print("am ajuns aici", self.profile)
        self.delegate?.profileReloadData()
    }
    
    func profileInfo() {
        fetchProfile()
    }
}

extension ProfileViewController: ProfileViewModelDelegate {
    func profileReloadData() {
        print("reload")
        self.viewDidLoad()
    }
}
