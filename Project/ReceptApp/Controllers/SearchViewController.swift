//
//  SearchViewController.swift
//  ReceptApp
//
//  Created by Gavin Schipper on 16-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SearchCellDelegate {
    // MARK: properties
    var results = [searchResult]()
    var ingredients: [String] = []
    var item = ""
    
    // outlets
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    // actions
    @IBAction func returnPressed(_ sender: Any) {
        ingredientTextField.resignFirstResponder()
    }
    
    /// fuwehog wheogh
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        
        self.ingredientsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        
        cell.delegate = self
        
        cell.ingredientLabel.text = ingredients[indexPath.row]
        
        return cell
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let seperatedStringCount = ingredientTextField.text?.components(separatedBy: .whitespaces)
        let stringCount = seperatedStringCount?.count
        
        if ingredientTextField.text == "" {
            showAlert(title: "Error", message: "There is nothing to be added to the ingredient list.")
        }
        
        else if stringCount! > 1 {
            showAlert(title: "Error", message: "An ingredient can only consist of one word.")
        }
        
        else {
            ingredients.append(ingredientTextField.text!)
            
            ingredientTextField.text = ""
            
            self.ingredientsTableView.reloadData()
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // delete ingredient
    func didTapButton(_ sender: UIButton) {
        if let indexPath = getCurrentCellIndexPath(sender) {
            ingredients.remove(at: indexPath.row)
            ingredientsTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func getCurrentCellIndexPath(_ sender: UIButton) -> IndexPath? {
        let buttonPosition = sender.convert(CGPoint.zero, to: ingredientsTableView)
        if let indexPath: IndexPath = ingredientsTableView.indexPathForRow(at: buttonPosition) {
            return indexPath
        }
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResults" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.query = ingredients.joined(separator: ",")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
