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

protocol LoginViewModelDelegate: AnyObject {
    func sendEmail() -> String
}

class ProfileViewModel {
    
    var profile = Profile()
    weak var delegate: ProfileViewModelDelegate?
    weak var delegateSwiftUI: ProfileSwiftUIViewModelDelegate?
    weak var delegateEmail: LoginViewModelDelegate?
    
    init() {
        fetchProfile()
    }
    
    private func fetchProfile() {
        self.profile.name = "Andreea Lupașcu"
        self.profile.email = self.delegateEmail?.sendEmail()
        print(self.delegateEmail?.sendEmail())
        self.profile.phone = "+40 728 717 259"
        self.delegate?.profileReloadData()
        self.delegateSwiftUI?.profileReloadData()
    }
    
    func profileInfo() {
        fetchProfile()
    }
}
