//
//  LoginViewController.swift
//  Fusion
//
//  Created by Mohammad Irteza Khan on 7/28/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

let currentUser = "currentUser"

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        let userName = userNameTextField.text
        let password = passwordTextField.text
        if userName != "" && password != "" {
            if checkLogin(userName: userName!, password: password!){
                performSegue(withIdentifier: "loginSuccessful", sender: view)
            }
            else{
                let alertView = UIAlertController.init(title: "Invalid Entry", message: "Username or password didn't match.", preferredStyle: .alert)
                let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
                alertView.addAction(okAction)
                present(alertView, animated: true, completion: nil)
            }
        }
        else {
            let alertView = UIAlertController.init(title: "Oops!", message: "Please enter username and password both.", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            alertView.addAction(okAction)
            present(alertView, animated: true, completion: nil)
        }
    }
    
    func checkLogin(userName: String, password: String) -> Bool{
        return password == KeychainWrapper.standard.string(forKey: userName)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSuccessful" {
            
        }
    }
    
    
}

