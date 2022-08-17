//
//  NetworkManager.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 16.08.2022.
//

import Foundation
import Network
import UIKit

class NetworkManager: ObservableObject {
    let offlineNoInternetView = InternetConnectionViewController()
    static let shared = NetworkManager()

    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkManager")
    var isConnected = true
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
