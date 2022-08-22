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
            case .reachable(.ethernetOrWiFi):
                self.dismissOfflineAlert()
            case .unknown:
                print("Unknown network state")
            }
        }
    }
    
    func showOfflineAlert() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let noInternetViewHostIdentifier = "noInternetViewHost"
        let offlineInternetVHC = storyBoard.instantiateViewController(withIdentifier: noInternetViewHostIdentifier) as! InternetVHC
        offlineInternetVHC.modalPresentationStyle = .fullScreen
        let rootViewController = UIApplication.shared.windows.first?.topViewController()
        rootViewController?.present(offlineInternetVHC, animated: true, completion: nil)
    }
    
    func dismissOfflineAlert() {
        let rootViewController = UIApplication.shared.windows.first?.topViewController()
        rootViewController?.dismiss(animated: true, completion: nil)
        
        NotificationCenter.default.post(name: .homeScreenMeal, object: nil)
        NotificationCenter.default.post(name: .searchScreen, object: nil)
        NotificationCenter.default.post(name: .mealDetailsScreen, object: nil)
    }

     
}

extension UIWindow {
    func topViewController() -> UIViewController? {
        var top = self.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}
