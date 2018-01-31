//
//  SearchViewController.swift
//  ReceptApp
//
//  The search view controller is the view that is immediately visible when the app is opened. In this view you can add the ingredients you want to use to a list. When the search button is pressed, the ingredientslist is transformed to a query and sent to the next screen.
//
//  Created by Gavin Schipper on 16-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SearchCellDelegate {
    
    // MARK: Properties
    var results = [searchResult]()
    var ingredients: [String] = []
    
    // MARK: Outlets
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    // MARK: Actions
    
    /// closes keyboard when return is pressed
    @IBAction func returnPressed(_ sender: Any) {
        ingredientTextField.resignFirstResponder()
    }
    
    /// Adds an ingredient to the list of ingredients for the query
    @IBAction func addButtonPressed(_ sender: Any) {
        let seperatedStringCount = ingredientTextField.text?.components(separatedBy: .whitespaces)
        let stringCount = seperatedStringCount?.count
        
        // Making sure the user is not adding an empty string to the ingredients list
        if ingredientTextField.text == "" {
            showAlert(title: "Error", message: "There is nothing to be added to the ingredient list.")
        }
        
        // Making sure the ingredients is one word without spaces
        else if stringCount! > 1 {
            showAlert(title: "Error", message: "An ingredient can only consist of one word.")
        }
            
        else {
            ingredients.append(ingredientTextField.text!)
            ingredientTextField.text = ""
            self.ingredientsTableView.reloadData()
        }
    }
    
    // MARK: Functions
    
    /// standard viewDidLoad function with tableview initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        
        self.ingredientsTableView.reloadData()
    }
    
    /// Ingredients tableview setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    /// Ingredients tableview setup
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        
        cell.delegate = self
        
        cell.ingredientLabel.text = ingredients[indexPath.row]
        
        return cell
    }
    
    /// removes ingredient from ingredient list when delete button in cell is pressed
    func didTapButton(_ sender: UIButton) {
        if let indexPath = getCurrentCellIndexPath(sender) {
            ingredients.remove(at: indexPath.row)
            ingredientsTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /// Checks at which row the delete button was pressed
    func getCurrentCellIndexPath(_ sender: UIButton) -> IndexPath? {
        let buttonPosition = sender.convert(CGPoint.zero, to: ingredientsTableView)
        if let indexPath: IndexPath = ingredientsTableView.indexPathForRow(at: buttonPosition) {
            return indexPath
        }
        return nil
    }
    
    /// prepare function for sending the query with the chosen ingredients to the resultsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResults" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.query = ingredients.joined(separator: ",")
        }
    }
    
    /// Closes the keyboard when the screen is pressed anywhere but the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
