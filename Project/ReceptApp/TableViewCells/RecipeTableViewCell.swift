//
//  CustomTableViewCell.swift
//  ReceptApp
//
//  The tableview cell class that belongs to the tableviews in the ResultsViewController and the FavoritesViewController
//
//  Created by Gavin Schipper on 18-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
