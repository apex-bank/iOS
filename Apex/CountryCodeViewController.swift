//
//  CountryCodeViewController.swift
//  Apex
//
//  Created by Brett Hales on 4/10/19.
//  Copyright © 2019 Brett Hales. All rights reserved.
//

import Foundation
import UIKit

class countryCodeViewController: UIViewController {
    
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "backtowelcome", sender: self)
    }
    
}
