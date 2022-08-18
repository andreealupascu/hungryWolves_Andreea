//
//  InternetVHC.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 18.08.2022.
//

import Foundation
import SwiftUI

class InternetVHC: UIHostingController<NoInternetView> {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: NoInternetView())
    }
}
