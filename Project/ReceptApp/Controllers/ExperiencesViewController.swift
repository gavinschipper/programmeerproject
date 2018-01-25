//
//  ExperiencesViewController.swift
//  ReceptApp
//
//  Created by Gavin Schipper on 24-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit
import Firebase

class ExperiencesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    let ref: DatabaseReference! = Database.database().reference()
    
    var chosenRecipe: recipe!
    var experiences = [experience]()

    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var shareExperienceButton: UIButton!
    @IBOutlet weak var experiencesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        experiencesTableView.delegate = self
        experiencesTableView.dataSource = self
        
        recipeNameLabel.text = chosenRecipe.title
        
        if Auth.auth().currentUser == nil {
            shareExperienceButton.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ref.child("experiences").child(chosenRecipe.recipeID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                self.experiences = []
                
                for item in snapshot.children.allObjects as! [DataSnapshot] {
                    let experienceObject = item.value as? [String: String]
                    let userID = experienceObject?["userID"]
                    let username = experienceObject?["username"]
                    let experienceText = experienceObject?["experienceText"]
                    
                    let experienceToBeAdded = experience(experienceText: experienceText!, userID: userID!, username: username!)
                    
                    self.experiences.append(experienceToBeAdded)
                }
                self.experiencesTableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return experiences.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "experienceCell") as! ExperienceTableViewCell
        
        cell.usernameLabel.text = experiences[indexPath.row].username
        cell.experienceText.text = experiences[indexPath.row].experienceText
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        if segue.identifier == "showWriteExperience" {
            let WriteExperienceViewController = segue.destination as! WriteExperienceViewController
            let recipe = chosenRecipe
            WriteExperienceViewController.chosenRecipe = recipe
        }
    }

}
