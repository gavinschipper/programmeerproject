//
//  ResultsTableViewController.swift
//  ReceptApp
//
//  Created by Gavin Schipper on 18-01-18.
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

class ResultsTableViewController: UITableViewController {
    
    var results = [searchResult]()
    var query = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ResultsController.shared.fetchSearchResults(query: query) { (searchResults) in
            if let searchResults = searchResults {
                self.updateUI(with: searchResults.recipes)
            }
        }
    }
    
    func updateUI(with searchResults: [searchResult]) {
        DispatchQueue.main.async {
            self.results = searchResults
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
            let index = tableView.indexPathForSelectedRow!.row
            RecipeDetailViewController.recipeID = results[index].recipeID
        }
    }
}
