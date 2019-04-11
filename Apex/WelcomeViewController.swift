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
    @IBOutlet weak var subHeaderLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var countryCodeTextField: HoshiTextField!
    @IBOutlet weak var phoneNumberTextField: HoshiTextField!
    
    
    @IBOutlet weak var continueButton: AnimatableButton!
    @IBOutlet weak var continueButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var phoneNumberLabelError: UILabel!
   
    @IBOutlet weak var tempButton: UIButton!
    
    
   
    
    let keyboardMan = KeyboardMan()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Initialize()
        self.InitializeKeyboardMan()
    
        

        
      //  self.phoneNumberTextField.becomeFirstResponder()
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
        self.continueButton.fillColor = UIColor.deepSkyBlue
        
      //  phoneNumberTextField.delegate = self
        
        self.phoneNumberLabelError.isHidden = true
        
    }
    
    // MARK: For Keyboard Animation active
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
    
    //MARK: Checking phone number validation
    func isValidPhoneNumber(value: String) -> Bool {
        let PHONE_REGEX = "^((\\+)|(00))[0-8]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    // MARK: Goes to the next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "" {
            let enterpasscode = segue.destination as! passcodeViewController
          //  enterpasscode.phoneNumber = phoneNumberTextField.text!.trimmingCharacters(in: .whitespaces)
        }
    }
    
}

// MARK: UITextFieldDelegate Methods

extension welcomeViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.phoneNumberTextField {
            
            if textField.text == "" {
                
              //  textField.placeholder = UIColor.red
                self.phoneNumberLabelError.text = "This field is required."
                self.phoneNumberLabelError.isHidden = false
                
                return
            }
            
            else if String(textField.text!).count < 7 {
                
           //     textField.placeholder = UIColor.red
                self.phoneNumberLabelError.text = "Invalid Phone Number."
                self.phoneNumberLabelError.isHidden = false
                self.phoneNumberLabelError.textColor = UIColor.red
                
                return
                
            }
            
            else if String(textField.text!).count > 10 {
                
            //    textField.placeholder = UIColor.red
                self.phoneNumberLabelError.text = "Invalid Phone Number."
                self.phoneNumberLabelError.isHidden = false
                self.phoneNumberLabelError.textColor = UIColor.red
                
                return
            }
        }
    }
}
