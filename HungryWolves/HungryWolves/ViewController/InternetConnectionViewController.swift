//
//  InternetConnectionViewController.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 16.08.2022.
//

import UIKit
import SwiftUI

class InternetConnectionViewController: UIViewController {

    let swiftUIController = UIHostingController(rootView: NoInternetView())
    
    override func viewDidLoad() {
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
