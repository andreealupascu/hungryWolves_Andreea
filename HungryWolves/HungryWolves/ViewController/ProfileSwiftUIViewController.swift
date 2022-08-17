//
//  ProfileSwiftUIViewController.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 16.08.2022.
//

import UIKit
import SwiftUI

class ProfileSwiftUIViewController: UIViewController{
    
    @IBAction func unwindToProfileView(segue: UIStoryboardSegue) {
        
    }
    
    func favouriteButtonPressedVC() {
        tabBarController?.selectedIndex = 1
        print( "Fav button")
    }
    
    func termsAndConditionButtonTapped() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "webView") as! WebViewController
        self.present(nextViewController, animated:true, completion:nil)
        print("terms press")
    }
    
    override func viewDidLoad() {
        let profileView: ProfileSwiftUI = ProfileSwiftUI(
            termsAndConditionPressed: { [weak self] in self?.termsAndConditionButtonTapped()},
            favoriteButtonPressed: { [weak self] in self?.favouriteButtonPressedVC()
            })
        
        let swiftUIController = UIHostingController(rootView: profileView)
        
        super.viewDidLoad()
        addChild(swiftUIController)
        view.addSubview(swiftUIController.view)
        swiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        swiftUIController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        swiftUIController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        swiftUIController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        swiftUIController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
}
