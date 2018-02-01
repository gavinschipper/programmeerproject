//
//  IngredientsTableViewCell.swift
//  ReceptApp
//
//  The table view cell class that belongs to the tableview on the RecipeDetailViewController
//
//  Created by Gavin Schipper on 22-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientString: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
