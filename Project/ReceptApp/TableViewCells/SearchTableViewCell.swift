//
//  SearchTableViewCell.swift
//  ReceptApp
//
//  The table view cell class that belongs to the tableview in the SearchViewController
//
//  Created by Gavin Schipper on 19-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit

// Delegate for the delete button in the cell
protocol SearchCellDelegate: class {
    func didTapButton(_ sender: UIButton)
}

class SearchTableViewCell: UITableViewCell {
    
    var delegate: SearchCellDelegate?
    
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    // calls function for when delete button is pressed
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        delegate?.didTapButton(sender)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
