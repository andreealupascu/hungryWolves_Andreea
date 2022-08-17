//
//  NetworkConnection.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 16.08.2022.
//

import UIKit
import Alamofire


class NetworkConnection {
    static let shared = NetworkConnection()
    let reachabilityManager = NetworkReachabilityManager(host: "www.google.com")
    let offlineNoInternetView = InternetConnectionViewController()
    let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .first(where: { $0 is UIWindowScene })
        .flatMap({ $0 as? UIWindowScene })?.windows
        .first(where: \.isKeyWindow)
    
    
    func startNetworkMonitoring() {
        reachabilityManager?.startListening { status in
            switch status {
            case .notReachable:
                self.showOfflineAlert()
            case .reachable(.cellular):
                self.dismissOfflineAlert()
                HomeViewModel.init()
                SearchViewModel.init()
                MealDetailViewModel.init()
                ProfileViewModel.init()
                FavouritesViewModel.init()
            case .reachable(.ethernetOrWiFi):
                self.dismissOfflineAlert()
            case .unknown:
                print("Unknown network state")
            }
        }
    }
    
    func showOfflineAlert() {
        let rootViewController = UIApplication.shared.windows.first?.rootViewController
        rootViewController?.present(offlineNoInternetView, animated: true, completion: nil)
    }
    
    func dismissOfflineAlert() {
        let rootViewController = UIApplication.shared.windows.first?.rootViewController
        rootViewController?.dismiss(animated: true, completion: nil)
    }
}

