//
//  FavoritesViewController.swift
//  ReceptApp
//
//  Created by Gavin Schipper on 25-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit
import Firebase

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var favorites = [recipe]()
    var currentFavoritesArray = [recipe]()
    
    @IBOutlet weak var loginMessage: UILabel!
    @IBOutlet weak var favoritesSearchBar: UISearchBar!
    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
        favoritesTableView.alpha = 0
        
        super.viewDidLoad()
        favoritesTableView.tableFooterView = UIView(frame: CGRect.zero)
        setupSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        favoritesSearchBar.text = ""
        updateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateUI() {
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
                    self.currentFavoritesArray = self.favorites
                    self.favoritesTableView.reloadData()
                    
                    UIView.animate(withDuration: 0.2, animations: {
                        self.favoritesTableView.alpha = 1
                        return
                    })
                }
            })
        } else {
            loginWarning()
        }
    }
    
    func setupSearchBar() {
        favoritesSearchBar.delegate = self
    }
    
    func loginWarning() {
        
        // create the alert
        let alert = UIAlertController(title: "No favorites", message: "You are not logged in. Therefore you can't see any favorites.", preferredStyle: UIAlertControllerStyle.alert)
    
        // add actions
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Login", style: .default, handler: { action in
            let accountViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! AccountViewController
            self.navigationController?.pushViewController(accountViewController, animated: true)
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    // Table setup
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
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        if segue.identifier == "showRecipeDetails" {
            let RecipeDetailViewController = segue.destination as! RecipeDetailViewController
            let index = favoritesTableView.indexPathForSelectedRow!.row
            RecipeDetailViewController.recipeID = currentFavoritesArray[index].recipeID
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
