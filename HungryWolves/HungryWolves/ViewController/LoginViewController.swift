//
//  LoginViewController.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 18.08.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    
    @IBAction func emailAction(_ sender: UITextField) {
        if isValidEmailAddr(strToValidate: emailTextField.text ?? "") == true {
            errorMessageLabel.text = ""
            emailBool = true
            email = emailTextField.text ?? ""
        } else {
            errorMessageLabel.text = "Email invalid. Retry"
        }
    }
    
    @IBAction func passwordAction(_ sender: Any) {
        if emailBool == true {
            if validatePassword(strToValidate: passwordTextField.text ?? "") {
                loginButton.isEnabled = true
                email = emailTextField.text ?? ""
            } else {
                errorMessageLabel.text = "Password is not strong enough. Retry"
            }
        }
    }
        
    @IBAction func loginButtonAction(_ sender: Any) {
        self.profileViewModel.delegateEmail = self
    }
    
    var email = ""
    var emailBool: Bool = false
    var password = ""
    let profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 20
        loginButton.isEnabled = false
        errorMessageLabel.text = ""
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
    }
    
    func isValidEmailAddr(strToValidate: String) -> Bool {
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        
        return emailValidationPredicate.evaluate(with: strToValidate)
    }
    
    func validatePassword(strToValidate: String) -> Bool {
        if strToValidate.count > 6 {
            return true
        } else {
            return false
        }
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func sendEmail() -> String {
            print(email)
        return email
    }
}
