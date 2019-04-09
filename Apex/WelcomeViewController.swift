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
    
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var countryPicker: UIView!
    @IBOutlet weak var phoneNumberTextField: HoshiTextField!
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var continueButton: AnimatableButton!
    
    let keyboardMan = KeyboardMan()
    
    var validate: Bool = false {
        didSet {
            if validate {
                self.continueButton.fillColor = UIColor.green
            }
            else {
                self.continueButton.fillColor = UIColor.lightGray
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.Initialize()
        self.InitializeKeyboardMan()
        self.dismiss(animated: true, completion: nil)
        
      
    }
    
    
    //MARK: Initialize UI properties
    func Initialize(){
        
        self.continueButton.fillColor = UIColor.lightGray
        
        phoneNumberTextField.delegate = self
        
    }
    
    // MARK: Keyboard Man Initializer
    func InitializeKeyboardMan() {
        
        self.bottomConstraint.constant = 50
        
        // - When keyboard will show
        self.keyboardMan.animateWhenKeyboardAppear = { [weak self] appearPostIndex, keyboardHeight, keyboardHeightIncrement in
            
            print("Appear height: \(keyboardHeight) ===== \(keyboardHeightIncrement)")
            
            if let self = self {
            
            self.widthConstraint.constant = self.view.frame.width
            self.bottomConstraint.constant = keyboardHeight
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
                self.bottomConstraint.constant = 50
                UIView.animate(withDuration: 0.5) {
                    self.view.layoutIfNeeded()
                }
            }

        }
    }
    
    //MARK: Checking Phone Number Valid
    func isValidPhoneNumber(value: String) -> Bool {
        let PHONE_REGEX = "^((\\+)|(00))[0-8]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
}

extension welcomeViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
}
