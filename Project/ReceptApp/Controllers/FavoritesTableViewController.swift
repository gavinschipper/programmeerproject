//
//  FavoritesTableViewController.swift
//  ReceptApp
//
//  Created by Gavin Schipper on 23-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit
import Firebase

class FavoritesTableViewController: UITableViewController {
    
    var favorites = [recipe]()

    @IBOutlet weak var favoritesSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let userID = Auth.auth().currentUser?.uid
        
        let ref: DatabaseReference! = Database.database().reference()
        if Auth.auth().currentUser != nil {
            ref.child("users").child(userID!).child("favorites").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if snapshot.childrenCount > 0 {
                    self.favorites = []
                    for favorite in snapshot.children.allObjects as! [DataSnapshot] {
                        let favoriteObject = favorite.value as? [String: AnyObject]
                        let id = favoriteObject?["id"]
                        let title = favoriteObject?["title"]
                        let image = favoriteObject?["image"]
                        let source = favoriteObject?["source"]
                        let ingredients = favoriteObject?["ingredients"]
                        
                        let favoriteToBeAdded = recipe(ingredients: ingredients as! [String], sourceURL: source as! String, recipeID: id as! String, imageURL: image as! String, title: title as! String)
                        
                        self.favorites.append(favoriteToBeAdded)
                    }
                    self.tableView.reloadData()
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell") as! RecipeTableViewCell

        cell.recipeName.text = favorites[indexPath.row].title
        let urlString = favorites[indexPath.row].imageURL
        let newUrlString = urlString.replacingOccurrences(of: "http://", with: "https://")
        let url = URL(string: newUrlString)
        cell.recipeImage.downloadedFrom(url: url!, contentMode: .scaleAspectFill)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        if segue.identifier == "showRecipeDetails" {
            let RecipeDetailViewController = segue.destination as! RecipeDetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            RecipeDetailViewController.recipeID = favorites[index].recipeID
        }
    }

}
