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
    @IBOutlet weak var experiencesTableView: UITableView!
    @IBOutlet weak var writeExperienceButton: UIBarButtonItem!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var shadowLayerPhoto: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        experiencesTableView.delegate = self
        experiencesTableView.dataSource = self
        
        experiencesTableView.estimatedRowHeight = 150
        experiencesTableView.rowHeight = UITableViewAutomaticDimension
        
        experiencesTableView.alpha = 0
        
        recipeNameLabel.text = chosenRecipe.title
        recipeImage.downloadedFrom(link: chosenRecipe.imageURL.replacingOccurrences(of: "http://", with: "https://"), contentMode: .scaleAspectFill)
        
        shadowLayerPhoto.layer.masksToBounds = false
        shadowLayerPhoto.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadowLayerPhoto.layer.shadowColor = UIColor.black.cgColor
        shadowLayerPhoto.layer.shadowOpacity = 0.3
        shadowLayerPhoto.layer.shadowRadius = 4
        
        if Auth.auth().currentUser == nil {
            writeExperienceButton.isEnabled = false
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
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.experiencesTableView.alpha = 1
                    return
                })
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return experiences.count
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        if segue.identifier == "showWriteExperience" {
            let WriteExperienceViewController = segue.destination as! WriteExperienceViewController
            let recipe = chosenRecipe
            WriteExperienceViewController.chosenRecipe = recipe
        }
    }

}
