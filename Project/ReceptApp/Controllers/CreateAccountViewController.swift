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
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            // zorgt ervoor dat de alert weggeklikt kan worden
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            let email = self.emailTextField.text!
            let username = self.usernameTextField.text!
            let password = self.passwordTextField.text!
            
            createUser(username: username, email: email, password: password)
        }
    }
    
    func createUser(username: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            // Als er geen error is, ga terug naar login pagina
            if error == nil {
                
                guard let uid = user?.uid else {
                    return
                }
                
                let userReference = self.ref.child("users").child(uid)
                let values = ["username": username, "email": email]
                
                userReference.updateChildValues(values)
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "startScherm")
                self.present(vc!, animated: true, completion: nil)
                
            }
                
                // Als er een error is, laat een waarschuwing zien met wat het probleem is.
            else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                // zorgt ervoor dat de alert weggeklikt kan worden
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
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
