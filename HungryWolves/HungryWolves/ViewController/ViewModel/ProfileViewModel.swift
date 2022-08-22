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

protocol ProfileSwiftUIViewModelDelegate: AnyObject {
    func profileReloadData()
}

class ProfileViewModel {
    
    var profile = Profile()
    let defaults = UserDefaults.standard
    weak var delegate: ProfileViewModelDelegate?
    weak var delegateSwiftUI: ProfileSwiftUIViewModelDelegate?
    
    init() {
        fetchProfile()
    }
    
    private func fetchProfile() {
        self.profile.name = "Andreea Lupașcu"
        self.profile.email = defaults.string(forKey: "Email")
        self.profile.phone = "+40 728 717 259"
        self.delegate?.profileReloadData()
        self.delegateSwiftUI?.profileReloadData()
    }
    
    func profileInfo() {
        fetchProfile()
    }
}
