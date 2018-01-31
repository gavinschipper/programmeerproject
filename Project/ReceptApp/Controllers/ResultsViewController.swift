//
//  ResultsViewController.swift
//  ReceptApp
//
//  Created by Gavin Schipper on 31-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var results = [searchResult]()
    var query = ""

    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        
        resultsTableView.alpha = 0

        ResultsController.shared.fetchSearchResults(query: query) { (searchResults) in
            if let searchResults = searchResults {
                self.updateUI(with: searchResults.recipes)
            }
        }
    }
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell") as! RecipeTableViewCell
        
        cell.recipeName.text = results[indexPath.row].title
        let urlString = results[indexPath.row].imageURL
        let newUrlString = urlString.replacingOccurrences(of: "http://", with: "https://")
        let url = URL(string: newUrlString)
        cell.recipeImage.downloadedFrom(url: url!, contentMode: .scaleAspectFill)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        if segue.identifier == "showRecipeDetails" {
            let RecipeDetailViewController = segue.destination as! RecipeDetailViewController
            let index = resultsTableView.indexPathForSelectedRow!.row
            RecipeDetailViewController.recipeID = results[index].recipeID
        }
    }

}
