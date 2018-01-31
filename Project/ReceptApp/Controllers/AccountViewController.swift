//
//  LoginViewController.swift
//  ReceptApp
//
//  
//
//  Created by Gavin Schipper on 16-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {
    
    // MARK: Outlets
    
    // Shown when not logged in
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    // Shown when logged in
    @IBOutlet weak var loggedInStackView: UIStackView!
    @IBOutlet weak var loggedInLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    
    // MARK: Actions
    
    /// Checks if the fields are empty. If not, the user is logged in or an error is given.
    @IBAction func loginButtonPressed(_ sender: Any) {
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            showAlert(title: "Error", message: "Please enter an email and password.")
            
        } else {
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "startScherm")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    self.showAlert(title: "Error", message: (error?.localizedDescription)!)
                    
                }
            }
        }
    }
    
    /// Logs out the user and sends the user to the login screen
    @IBAction func logOutButtonPressed(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                let accountViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! AccountViewController
                self.navigationController?.pushViewController(accountViewController, animated: true)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: Functions
    
    /// Standard viewDidLoad which also hides the backbutton and hides the right objects for the right user.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: true)
        
        if Auth.auth().currentUser != nil {
            statusLabel.isHidden = true
            emailTextField.isHidden = true
            passwordTextField.isHidden = true
            loginButton.isHidden = true
            createAccountButton.isHidden = true
            
            loadUsername()
            
        } else {
            loggedInStackView.isHidden = true
            logOutButton.isHidden = true
        }
    }
    
    /// Retrieves username of current user from Firebase and sets the usernameLabel
    func loadUsername() {
        let userID = Auth.auth().currentUser?.uid
        
        let ref: DatabaseReference! = Database.database().reference()
        
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            self.usernameLabel.text = username
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    /// Closes the keyboard when the screen is pressed anywhere but the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
