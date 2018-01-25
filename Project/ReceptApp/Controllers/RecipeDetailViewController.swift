//
//  RecipeDetailViewController.swift
//  ReceptApp
//
//  Created by Gavin Schipper on 19-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit
import Firebase

class RecipeDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let ref: DatabaseReference! = Database.database().reference()
    
    var chosenRecipe: recipe!
    var recipeID = ""
    var experienceCount: Int = 0

    @IBOutlet weak var isFavoriteButton: UIButton!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var instructionsButton: UIButton!
    @IBOutlet weak var experiencesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        
        getExperienceCount()
        
        ResultsController.shared.fetchRecipeResult(query: recipeID) { (searchedRecipe) in
            if let searchedRecipe = searchedRecipe {
                self.chosenRecipe = searchedRecipe.recipe
                self.updateUI(with: self.chosenRecipe)
            }
        }
        
        switchFavorite()
    }
    
    @IBAction func isFavoriteButtonPressed(_ sender: Any) {
        isFavoriteButton.isSelected = !isFavoriteButton.isSelected
        
        let userID = Auth.auth().currentUser?.uid
        let userReference = self.ref.child("users").child(userID!).child("favorites")
        
        if isFavoriteButton.isSelected == true {
            userReference.child(recipeID).setValue(["id":recipeID, "title":chosenRecipe.title, "image":chosenRecipe.imageURL, "source":chosenRecipe.sourceURL, "ingredients":chosenRecipe.ingredients])
            
        } else if isFavoriteButton.isSelected != true {
            userReference.child(recipeID).removeValue()
        }
    }
    
    func updateUI(with recipe: recipe) {
        DispatchQueue.main.async {
            let urlString = recipe.imageURL
            let newUrlString = urlString.replacingOccurrences(of: "http://", with: "https://")
            let url = URL(string: newUrlString)
            self.recipeImage.downloadedFrom(url: url!, contentMode: .scaleAspectFill)
            
            self.recipeName.text = recipe.title
            
            self.experiencesButton.setTitle("Experiences (\(self.experienceCount))", for: .normal)
            
            self.ingredientsTableView.reloadData()
        }
    }
    
    func switchFavorite() {
        if Auth.auth().currentUser == nil {
            isFavoriteButton.isHidden = true
        } else {
            var recipeIDs: [String] = []
            
            let userID = Auth.auth().currentUser?.uid
            ref.child("users").child(userID!).child("favorites").observeSingleEvent(of: .value, with: { (snapshot) in
                
                for child in snapshot.children {
                    
                    let snap = child as! DataSnapshot
                    let key = snap.key
                    
                    recipeIDs.append(key)
                }
                
                if recipeIDs.contains(self.recipeID) {
                    self.isFavoriteButton.isSelected = true
                }
            })
        }
    }
    
    func getExperienceCount() {
        ref.child("experiences").child(recipeID).observeSingleEvent(of: .value, with: { (snapshot) in
            self.experienceCount = Int(snapshot.childrenCount)
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if chosenRecipe == nil {
            return 0
        } else {
           return chosenRecipe.ingredients.count
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell") as! IngredientsTableViewCell

        cell.ingredientString.text = chosenRecipe.ingredients[indexPath.row]

        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        if segue.identifier == "showInstructions" {
            let InstructionsViewController = segue.destination as! InstructionsViewController
            let instructionsURL = chosenRecipe.sourceURL
            InstructionsViewController.recipeURL = instructionsURL
        }
        
        if segue.identifier == "showExperiences" {
            let ExperiencesViewController = segue.destination as! ExperiencesViewController
            let recipe = chosenRecipe
            ExperiencesViewController.chosenRecipe = recipe
        }
    }

}
