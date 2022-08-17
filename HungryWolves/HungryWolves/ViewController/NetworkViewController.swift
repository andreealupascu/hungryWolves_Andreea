//
//  NetworkViewController.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 16.08.2022.
//

import UIKit
import SwiftUI

struct NetworkViewController: UIViewController {
    
    let swiftUIController = UIHostingController(rootView: NoInternetView())
    
    func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(swiftUIController.view)
    }
    
}
