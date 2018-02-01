//
//  ExperiencesViewController.swift
//  ReceptApp
//
//  The ExperiencesViewController shows the experiences that user have written about a recipe. The controller collects all of the experiences and shows them in a tableview. For logged in users there is also a possibility to write an experience.
//
//  Created by Gavin Schipper on 24-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit
import Firebase

class ExperiencesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    // MARK: Properties
    let ref: DatabaseReference! = Database.database().reference()
    var chosenRecipe: recipe!
    var experiences = [experience]()

    // MARK: Outlets
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var experiencesTableView: UITableView!
    @IBOutlet weak var writeExperienceButton: UIBarButtonItem!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var shadowLayerPhoto: UIView!
    
    // MARK: Functions
    
    /// Initializes the tableview and makes the tableview rowheight automatic. Also the UI is updated.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        experiencesTableView.delegate = self
        experiencesTableView.dataSource = self
        
        experiencesTableView.estimatedRowHeight = 150
        experiencesTableView.rowHeight = UITableViewAutomaticDimension
        
        updateUI()
    }
    
    /// Everytime the view is opened the experiences of the current recipe are loaded and put in an experiences array. The tableview is reloaded with this array. When this is done, the tableview appears with a fade in.
    override func viewDidAppear(_ animated: Bool) {
        ref.child("experiences").child(chosenRecipe.recipeID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                self.experiences = []
                
                self.getExperiences(snapshot: snapshot)
                
                self.experiencesTableView.reloadData()
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.experiencesTableView.alpha = 1
                    return
                })
            }
        })
    }
    
    /// retrieves all experiences from the database and appends them to the experiences array
    func getExperiences(snapshot: DataSnapshot) {
        for item in snapshot.children.allObjects as! [DataSnapshot] {
            let experienceObject = item.value as? [String: String]
            let userID = experienceObject?["userID"]
            let username = experienceObject?["username"]
            let experienceText = experienceObject?["experienceText"]
            
            let experienceToBeAdded = experience(experienceText: experienceText!, userID: userID!, username: username!)
            
            self.experiences.append(experienceToBeAdded)
        }
    }

    /// Gives all outlets their right values and adds a shadow to the photo. Disables the write experience button if there is no user logged in.
    func updateUI() {
        experiencesTableView.alpha = 0
        
        recipeNameLabel.text = chosenRecipe.title
        recipeImage.downloadedFromLink(link: chosenRecipe.imageURL.replacingOccurrences(of: "http://", with: "https://"), contentMode: .scaleAspectFill)
        
        shadowLayerPhoto.layer.masksToBounds = false
        shadowLayerPhoto.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadowLayerPhoto.layer.shadowColor = UIColor.black.cgColor
        shadowLayerPhoto.layer.shadowOpacity = 0.3
        shadowLayerPhoto.layer.shadowRadius = 4
        
        if Auth.auth().currentUser == nil {
            writeExperienceButton.isEnabled = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return experiences.count
    }
    
    /// Makes a cell for every experience using the class ExperienceTableViewCell. All outlets are given their right values and the experience block is upgraded with round corners, a border and a shadow
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "experienceCell") as! ExperienceTableViewCell
        
        cell.usernameLabel.text = experiences[indexPath.row].username
        cell.experienceText.text = experiences[indexPath.row].experienceText
        
        cell.backgroundBlock.layer.cornerRadius = 10
        cell.backgroundBlock.layer.masksToBounds = true
        
        cell.shadowLayer.layer.cornerRadius = 10
        cell.shadowLayer.layer.masksToBounds = true
        
        cell.backgroundBlock.layer.borderWidth = 3
        cell.backgroundBlock.layer.borderColor = UIColor.white.cgColor
        
        cell.shadowLayer.layer.masksToBounds = false
        cell.shadowLayer.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.shadowLayer.layer.shadowColor = UIColor.black.cgColor
        cell.shadowLayer.layer.shadowOpacity = 0.3
        cell.shadowLayer.layer.shadowRadius = 4
        
        return cell
    }
    
    /// If the writeExperience button is tapped, the recipe is sent to the WriteExperienceViewController
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        if segue.identifier == "showWriteExperience" {
            let WriteExperienceViewController = segue.destination as! WriteExperienceViewController
            let recipe = chosenRecipe
            WriteExperienceViewController.chosenRecipe = recipe
        }
    }

}
