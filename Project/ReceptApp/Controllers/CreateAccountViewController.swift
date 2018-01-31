//
//  CreateAccountViewController.swift
//  ReceptApp
//
//  Created by Gavin Schipper on 18-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {
    
    let ref: DatabaseReference! = Database.database().reference()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func createAccountButtonPressed(_ sender: Any) {
        
        if emailTextField.text == "" {
            showAlert(title: "Error", message: "Please enter your email and password")
            
        } else {
            let email = self.emailTextField.text!
            let username = self.usernameTextField.text!
            let password = self.passwordTextField.text!
            
            createUser(username: username, email: email, password: password)
        }
    }
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
