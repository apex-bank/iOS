//
//  WelcomeViewController.swift
//  Apex
//
//  Created by Brett Hales on 4/9/19.
//  Copyright © 2019 Brett Hales. All rights reserved.
//

import Foundation
import UIKit
import TextFieldEffects
import KeyboardMan
import IBAnimatable

class welcomeViewController: UIViewController {
 
    // IB Outlets
    @IBOutlet weak var logImage: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var countryPicker: UIView!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var countryCodeLine: UIView!
    @IBOutlet weak var phoneNumberTextField: HoshiTextField!
    @IBOutlet weak var continueButton: AnimatableButton!
    @IBOutlet weak var continueButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var phoneNumberLabelError: UILabel!
    @IBOutlet weak var countryCodeButton: UIButton!
    @IBOutlet weak var tempButton: UIButton!
    
    
    
    
    let keyboardMan = KeyboardMan()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Initialize()
        self.InitializeKeyboardMan()
    }
    
    
    @IBAction func continueButton(_ sender: Any) {
      //  if self.validate {
      //      self.performSegue(withIdentifier: "", sender: self)
       // }
    }
    
    // MARK: used for viewing end and editing when touches view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    func Initialize() {
        self.continueButton.fillColor = UIColor.lightGray
        
      //  phoneNumberTextField.delegate = self
        
        self.phoneNumberLabelError.isHidden = true
        
    }
    
    func InitializeKeyboardMan() {
        self.continueButtonHeightConstraint.constant = 50
        
        // When the keyboard will show
        self.keyboardMan.animateWhenKeyboardAppear = { [weak self] appearPostIndex, keyboardHeight, keyboardHeightIncrement in
            
            print("Appear height: \(keyboardHeight) ====== \(keyboardHeightIncrement)")
            
            if let self = self {
                
                self.widthConstraint.constant = self.view.frame.width
                self.continueButtonHeightConstraint.constant = keyboardHeight
                UIView.animate(withDuration: 0.5) {
                    self.view.layoutIfNeeded()
                }
            }
        }
        
        // When keyboard will hide
        self.keyboardMan.animateWhenKeyboardDisappear = { [weak self] keyboardHeight in
            
            print("dismiss height: \(keyboardHeight)")
            
            if let self = self {
                
                self.widthConstraint.constant = 300
                self.continueButtonHeightConstraint.constant = 50
                UIView.animate(withDuration: 0.5) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
}
