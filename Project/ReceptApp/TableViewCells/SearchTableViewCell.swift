//
//  SearchTableViewCell.swift
//  ReceptApp
//
//  Created by Gavin Schipper on 19-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit

protocol SearchCellDelegate: class {
    func didTapButton(_ sender: UIButton)
}

class SearchTableViewCell: UITableViewCell {
    
    var delegate: SearchCellDelegate?
    
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        delegate?.didTapButton(sender)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
