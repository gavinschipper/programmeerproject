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
        if Auth.auth().currentUser != nil {
            
            let userID = Auth.auth().currentUser?.uid
            
            let ref: DatabaseReference! = Database.database().reference()
            
            ref.child("users").child(userID!).child("favorites").observeSingleEvent(of: .value, with: { (snapshot) in
                
                for child in snapshot.children {
                    
                    let snap = child as! DataSnapshot
                    let key = snap.key
                    
                    ResultsController.shared.fetchRecipeResult(query: key) { (searchedRecipe) in
                        if let searchedRecipe = searchedRecipe {
                            self.favorites.append(searchedRecipe.recipe)
                        }
                    }
                }
            })
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(favorites.count)
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

}
