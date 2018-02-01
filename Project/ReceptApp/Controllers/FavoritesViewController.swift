//
//  FavoritesViewController.swift
//  ReceptApp
//
//  The FavoritesViewController shows all the favorites of a user in a tableview. The view contains a searchbar which makes it possible to search for a specific recipe in the favorites list. If the user is not logged in, a popup shows which tells the user he/she is not logged in. There is a button that redirects the user to the login page.
//
//  Created by Gavin Schipper on 25-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit
import Firebase

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    // MARK: Properties
    var favorites = [recipe]()
    var currentFavoritesArray = [recipe]()
    
    // MARK: Outlets
    @IBOutlet weak var favoritesSearchBar: UISearchBar!
    @IBOutlet weak var favoritesTableView: UITableView!
    
    // MARK: Functions
    
    /// Initializes the tableview and the search bar is set up.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
        setupSearchBar()
    }
    
    /// Makes sure the search bar does not contain text and the tableview is invisible when the view shows
    override func viewWillAppear(_ animated: Bool) {
        favoritesSearchBar.text = ""
        favoritesTableView.alpha = 0
    }
    
    // Updates the UI every time the view shows
    override func viewDidAppear(_ animated: Bool) {
        updateUI()
    }
    
    // Makes sure the keyboard closes when another view comes up
    override func viewWillDisappear(_ animated: Bool) {
        favoritesSearchBar.endEditing(true)
    }
    
    /// Initializes the search bar
    func setupSearchBar() {
        favoritesSearchBar.delegate = self
    }
    
    /// Retrieves the favorites of a user and puts them in the tableview if the user is logged in. If this is all done the tableview fades in. If the user is not logged in a alert is shown.
    func updateUI() {
        let userID = Auth.auth().currentUser?.uid
        
        let ref: DatabaseReference! = Database.database().reference()
        if Auth.auth().currentUser != nil {
            ref.child("users").child(userID!).child("favorites").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if snapshot.childrenCount > 0 {
                    self.favorites = []
                    self.getFavorites(snapshot: snapshot)
                    self.currentFavoritesArray = self.favorites
                    self.favoritesTableView.reloadData()
                    
                    UIView.animate(withDuration: 0.2, animations: {
                        self.favoritesTableView.alpha = 1
                        return
                    })
                }
            })
        } else {
            favoritesTableView.alpha = 0
            loginWarning()
        }
    }
    
    ///
    func getFavorites(snapshot: DataSnapshot) {
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
    }
    
    /// shows an alert if the user is not logged in
    func loginWarning() {
        
        let alert = UIAlertController(title: "No favorites", message: "You are not logged in. Therefore you can't see any favorites.", preferredStyle: UIAlertControllerStyle.alert)
        
        // If the user does not want to login
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        // If the user wants to login
        alert.addAction(UIAlertAction(title: "Login", style: .default, handler: { action in
            let accountViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! AccountViewController
            self.navigationController?.pushViewController(accountViewController, animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // Tableview setup
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentFavoritesArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell") as! RecipeTableViewCell
        
        cell.recipeName.text = currentFavoritesArray[indexPath.row].title
        let urlString = currentFavoritesArray[indexPath.row].imageURL
        let newUrlString = urlString.replacingOccurrences(of: "http://", with: "https://")
        let url = URL(string: newUrlString)
        cell.recipeImage.downloadedFrom(url: url!, contentMode: .scaleAspectFill)
        
        return cell
    }
    
    // Search bar setup
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentFavoritesArray = favorites
            favoritesTableView.reloadData()
            return
        }
        
        currentFavoritesArray = favorites.filter({ favorite -> Bool in
            favorite.title.lowercased().contains(searchText.lowercased())
        })
        
        favoritesTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.favoritesSearchBar.endEditing(true)
    }
    
    /// Sends the recipeID to the RecipeDetailViewController if a recipe is tapped
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        if segue.identifier == "showRecipeDetails" {
            let RecipeDetailViewController = segue.destination as! RecipeDetailViewController
            let index = favoritesTableView.indexPathForSelectedRow!.row
            RecipeDetailViewController.recipeID = currentFavoritesArray[index].recipeID
        }
    }
    

    
}
