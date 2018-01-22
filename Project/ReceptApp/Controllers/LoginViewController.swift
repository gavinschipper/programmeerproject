//
//  LoginViewController.swift
//  ReceptApp
//
//  Created by Gavin Schipper on 16-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = Auth.auth().currentUser
        
        if (user) == nil {
//            statusLabel.isHidden = true
            emailTextField.isHidden = true
            passwordTextField.isHidden = true
//            loginButton.isHidden = true
//            createAccountButton.isHidden = true
            
//            loggedInStackView.isHidden = false
//            logOutButton.isHidden = false
        } else {
            print("HI")
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        //Als email, wachtwoord of beide leeg zijn krijgt de gebruiker een error
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            
            //Alert die de gebruiker vertelt dat ze iets moeten invullen bij email en wachtwoord.
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            //zorgt ervoor dat de alert weggeklikt kan worden
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            // Als er correct een wachtwoord en email is ingevuld, worden de gegevens gechecht met firebase
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                
                // Wordt uitgevoerd als de gegevens goed zijn
                if error == nil {
                    
                    // Go to startQuizViewController if the login is sucessful
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "startScherm")
                    self.present(vc!, animated: true, completion: nil)
                    
                    
                    // Wordt uitgevoerd als de gegevens niet kloppen
                } else {
                    
                    //laat de gebruiker een alert zien met wat er precies fout is gegaan.
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    //zorgt ervoor dat de alert weggeklikt kan worden
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
