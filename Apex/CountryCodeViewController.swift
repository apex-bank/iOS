//
//  CountryCodeViewController.swift
//  Apex
//
//  Created by Brett Hales on 4/10/19.
//  Copyright © 2019 Brett Hales. All rights reserved.
//

import Foundation
import UIKit

class countryCodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var countryCodeTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "backtowelcome", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryCodeTableView.delegate = self
        countryCodeTableView.dataSource = self
        
        // MARK: To remove unwanted lines from the table view
        countryCodeTableView.tableFooterView = UIView()
    
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableTitle", for: indexPath) as! CountryCodeCellTableViewCell
        
        if indexPath.row == 0 {
            cell.countryCodeLabel.text = "+61 Australia"
            cell.countryCodeFlag.image = #imageLiteral(resourceName: "flag-au")
        } else if indexPath.row == 1 {
            cell.countryCodeLabel.text = "+44 United Kingdom"
            cell.countryCodeFlag.image = #imageLiteral(resourceName: "flag-uk")
         
        }
            return cell
        
        
    }
    
}




    
    
    
    
   
    
    
    
    
   
    
    
    
 
   
    






