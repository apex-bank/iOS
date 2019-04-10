//
//  PasscodeNumberPadTextCollectionViewCell.swift
//  Apex
//
//  Created by Brett Hales on 4/10/19.
//  Copyright © 2019 Brett Hales. All rights reserved.
//

import UIKit

class PasscodeNumberPadTextCollectionViewCell: UICollectionViewCell {

    // Outlet
    
    @IBOutlet weak var keyLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(title: String) {
        
        self.keyLabel.text = title
        
    }
}
