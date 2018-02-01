//
//  WriteExperienceViewController.swift
//  ReceptApp
//
//  In the WriteExperienceViewController users are able to write an experience about the chosen recipe. If the user submits the experience, the experience is added to the database.
//
//  Created by Gavin Schipper on 24-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit
import Firebase

class WriteExperienceViewController: UIViewController {
    
    // MARK: Properties
    var chosenRecipe: recipe!
    var username: String = ""
    let userID = Auth.auth().currentUser?.uid
    let ref: DatabaseReference! = Database.database().reference()

    // MARK: Outlets
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var storyTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: Actions
    
    /// checks if the textView is empty and possibly shows an alert. Otherwise the experience is added to the database and shows an alert from where the user can go back to the ExperienceViewController.
    @IBAction func saveButtonPressed(_ sender: Any) {
        if storyTextView.text == "" {
            showAlert(title: "Error", message: "You didn't write any experiences to be added.")
            
        } else {
            let expReference = ref.child("experiences").child(chosenRecipe.recipeID)
            let expID = ref.childByAutoId().key
            
            expReference.child(expID).setValue(["userID": userID!, "username": username, "experienceText": storyTextView.text!])
            
            storyTextView.text = ""
            
            let alert = UIAlertController(title: "Thanks!", message: "Your experience with this recipe was added and is now accessible for others.", preferredStyle: UIAlertControllerStyle.alert)
            
            // Go back to the ExperienceViewController when 'OK' is tapped
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                self.navigationController?.popViewController(animated: true)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: Functions
    
    /// gives the outlets the right values, gives the textview a border and retrieves the username of the current user
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeNameLabel.text = chosenRecipe.title
        
        storyTextView.layer.borderWidth = 3.0
        let appRed = UIColor(red: 204/255, green: 83/255, blue: 67/255, alpha: 1)
        storyTextView.layer.borderColor = appRed.cgColor
        
        retrieveUsername()
    }
    
    /// Retrieves the username of the current user from the database
    func retrieveUsername() {
        
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.username = value?["username"] as? String ?? ""
        })
    }
    
    // Closes the keyboard when the screen is pressed anywhere but the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
