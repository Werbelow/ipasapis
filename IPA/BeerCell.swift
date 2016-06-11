//
//  BeerCell.swift
//  IPA
//
//  Created by Travis Werbelow on 6/10/16.
//  Copyright © 2016 Travis Werbelow. All rights reserved.
//

import UIKit

class BeerCell: UITableViewCell {

    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
