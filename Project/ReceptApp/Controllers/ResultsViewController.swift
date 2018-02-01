//
//  ResultsViewController.swift
//  ReceptApp
//
//  The resultsViewController collects the recipes that contain the given ingredients, using the fetch function. The results are loaded in the tableView. When a recipe is clicked, the recipeID is sent to the recipeDetailViewController.
//
//  Created by Gavin Schipper on 31-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    
    var results = [searchResult]()
    var query = ""

    // MARK: Outlets
    
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Functions
    
    /// viewDidLoad functions which initilizes the tableview, makes the tableview invisible and calls the fetch function to load the results.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        
        resultsTableView.alpha = 0
        
        // updateUI function is called using the retrieved result.
        ResultsController.shared.fetchSearchResults(query: query) { (searchResults) in
            if let searchResults = searchResults {
                self.updateUI(with: searchResults.recipes)
            }
        }
    }
    
    /// Reloads the tableview using the data that was retrieved from the API. When the tableview is reloaded the activity indicator is stopped and the tableview fades in.
    func updateUI(with searchResults: [searchResult]) {
        DispatchQueue.main.async {
            self.results = searchResults
            self.resultsTableView.reloadData()
            
            self.activityIndicator.stopAnimating()
            
            UIView.animate(withDuration: 0.2, animations: {
                self.resultsTableView.alpha = 1
                return
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    /// The outlets in the cells are given the right values using the RecipeTableViewCell class and after this the cell is returned.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell") as! RecipeTableViewCell
        
        cell.recipeName.text = results[indexPath.row].title
        let urlString = results[indexPath.row].imageURL
        let newUrlString = urlString.replacingOccurrences(of: "http://", with: "https://")
        let url = URL(string: newUrlString)
        cell.recipeImage.downloadedFrom(url: url!, contentMode: .scaleAspectFill)
        
        return cell
    }
    
    /// Sends the recipeID of the tapped recipe to the RecipeDetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        if segue.identifier == "showRecipeDetails" {
            let RecipeDetailViewController = segue.destination as! RecipeDetailViewController
            let index = resultsTableView.indexPathForSelectedRow!.row
            RecipeDetailViewController.recipeID = results[index].recipeID
        }
    }

}
