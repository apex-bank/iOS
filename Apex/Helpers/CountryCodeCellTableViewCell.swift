//
//  CountryCodeCellTableViewCell.swift
//  Apex
//
//  Created by Brett Hales on 4/12/19.
//  Copyright © 2019 Brett Hales. All rights reserved.
//

import UIKit

class CountryCodeCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var countryCodeFlag: UIImageView!
    @IBOutlet weak var countryCodeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
