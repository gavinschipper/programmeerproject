//
//  ExperienceTableViewCell.swift
//  ReceptApp
//
//  Created by Gavin Schipper on 24-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit

class ExperienceTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var experienceText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
