//
//  IngredientsTableViewCell.swift
//  ReceptApp
//
//  Created by Gavin Schipper on 22-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientString: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
