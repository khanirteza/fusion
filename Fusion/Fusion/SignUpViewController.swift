//
//  SignUpViewController.swift
//  Fusion
//
//  Created by Mohammad Irteza Khan on 7/30/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import CoreData

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var userPhoto: UIImageView!
    
    //let logNotification = "loggedInUser"
    
    var keyboardDidAppeared = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: self.view.window)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if keyboardDidAppeared{
            return
        }
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
                keyboardDidAppeared = true
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
                keyboardDidAppeared = false
            }
        }
    }
    
    @IBAction func selectPhotoFromLibrary(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        let firstName = firstNameTextField.text
        let lastName = lastNameTextField.text
        let emailAddress = emailAddressTextField.text
        let password = passwordTextField.text
        let zipCode = zipCodeTextField.text
        
        if firstName != "" && lastName != "" && emailAddress != "" && password != "" && zipCode != "" {
            if let _ = KeychainWrapper.standard.string(forKey: emailAddress!){
                let alertView = UIAlertController.init(title: "Existing User", message: "User already existed. Please enter different e-mail address.", preferredStyle: .alert)
                let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
                alertView.addAction(okAction)
                present(alertView, animated: true, completion: nil)
                return
            }
            
            KeychainWrapper.standard.set(password!, forKey: emailAddress!)
            
            let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: CoreDataStack.sharedCoreDataStack.persistentContainer.viewContext) as! User
            
            user.firstName = firstName
            user.lastName = lastName
            user.emailAddress = emailAddress
            user.zipCode = zipCode
            user.userPhoto = UIImagePNGRepresentation(userPhoto.image!)
            
            CoreDataStack.sharedCoreDataStack.saveContext()
            KeychainWrapper.standard.set(emailAddress!, forKey: currentUser)
            performSegue(withIdentifier: "signUpSuccessful", sender: view)
        }
        else{
            let alertView = UIAlertController.init(title: "Form Incomplete", message: "Please enter all the required information.", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            alertView.addAction(okAction)
            present(alertView, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            fatalError("Expected image but got \(info)")
        }
        
        userPhoto.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
