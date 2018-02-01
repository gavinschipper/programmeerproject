//
//  CreateAccountViewController.swift
//  ReceptApp
//
//  In the CreateAccountViewController the user is able to create an account. This is done by using Firebase. When the account is created, the username and email are also added to the database.
//
//  Created by Gavin Schipper on 18-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {
    
    // MARK: Properties
    
    let ref: DatabaseReference! = Database.database().reference()
    
    // MARK: Outlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: Actions
    
    /// Checks if the fields are not empty and if they are not the createUser function is called
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        
        if emailTextField.text == "" || usernameTextField.text == "" || passwordTextField.text == "" {
            showAlert(title: "Error", message: "Please enter your email, username and password")
            
        } else {
            let email = self.emailTextField.text!
            let username = self.usernameTextField.text!
            let password = self.passwordTextField.text!
            
            createUser(username: username, email: email, password: password)
        }
    }
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// Calls the Firebase createUser function. If the function gives an error, the error is shown in an alert. If there is no error, the user is created and the username is saved in the database.
    func createUser(username: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if error == nil {
                let uid = user?.uid
                let userReference = self.ref.child("users").child(uid!)
                let values = ["username": username, "email": email]
                
                userReference.updateChildValues(values)
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "startScherm")
                self.present(vc!, animated: true, completion: nil)
                
            }   else {
                    self.showAlert(title: "Error", message: (error?.localizedDescription)!)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
