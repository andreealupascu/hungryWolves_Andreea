//
//  WebViewController.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 16.08.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate  {

    @IBOutlet weak var webView: WKWebView!
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://www.wolfpack-digital.com/privacy"
        let urlRequest = URLRequest(url: URL(string: url)!)
        webView.load(urlRequest)
    }
}
