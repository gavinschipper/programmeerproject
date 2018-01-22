//
//  RecipeDetailViewController.swift
//  ReceptApp
//
//  Created by Gavin Schipper on 19-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // , UITableViewDelegate, UITableViewDataSource
    
    var chosenRecipe: recipe!
    var recipeID = ""

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var instructionsButton: UIButton!
    @IBOutlet weak var reviewsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        
        ResultsController.shared.fetchRecipeResult(query: recipeID) { (searchedRecipe) in
            if let searchedRecipe = searchedRecipe {
                self.chosenRecipe = searchedRecipe.recipe
                self.updateUI(with: self.chosenRecipe)
            }
        }
    }
    
    func updateUI(with recipe: recipe) {
        DispatchQueue.main.async {
            let urlString = recipe.imageURL
            let newUrlString = urlString.replacingOccurrences(of: "http://", with: "https://")
            let url = URL(string: newUrlString)
            self.recipeImage.downloadedFrom(url: url!, contentMode: .scaleAspectFill)
            
            self.recipeName.text = recipe.title
            
            self.ingredientsTableView.reloadData()
        }
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
    


}
