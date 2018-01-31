//
//  WriteExperienceViewController.swift
//  ReceptApp
//
//  Created by Gavin Schipper on 24-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit
import Firebase

class WriteExperienceViewController: UIViewController {
    
    var chosenRecipe: recipe!
    var username: String = ""
    
    let userID = Auth.auth().currentUser?.uid
    
    let ref: DatabaseReference! = Database.database().reference()

    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var storyTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeNameLabel.text = chosenRecipe.title
        
        storyTextView.layer.cornerRadius = 10
        storyTextView.layer.borderWidth = 3.0
        let appRed = UIColor(red: 204/255, green: 83/255, blue: 67/255, alpha: 1)
        storyTextView.layer.borderColor = appRed.cgColor
        saveButton.layer.cornerRadius = 5.0
        
        retrieveUsername()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            
            if storyTextView.text == "" {
                showAlert(title: "Error", message: "You didn't write any experiences to be added.")
                
            } else {
                
                let expReference = ref.child("experiences").child(chosenRecipe.recipeID)
                
                let expID = ref.childByAutoId().key
                
                expReference.child(expID).setValue(["userID": userID!, "username": username, "experienceText": storyTextView.text!])
                
                storyTextView.text = ""
                
                // create the alert
                let alert = UIAlertController(title: "Thanks!", message: "Your experience with this recipe was added and is now accessible for others.", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                }))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func retrieveUsername() {
        
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.username = value?["username"] as? String ?? ""
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
