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
   
    // Validation for the continue button
    var validate: Bool = false {
        didSet {
            if validate {
                self.continueButton.fillColor = UIColor.deepSkyBlue
        } else {
        self.continueButton.fillColor = UIColor.lightGray
        }
    }
}
    
    let keyboardMan = KeyboardMan()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.Initialize()
        self.InitializeKeyboardMan()
    
        phoneNumberTextField.text = UserDefaults.standard.string(forKey: "Phone")

        
      //  self.phoneNumberTextField.becomeFirstResponder()
    }
    
    // Continue Butotn
    @IBAction func continueButton(_ sender: Any) {
        if self.validate {
        let phoneNumberString = phoneNumberTextField.text!.trimmingCharacters(in: .whitespaces)

            self.createNewUser(phoneNumber: phoneNumberString)
          //  self.performSegue(withIdentifier: "enterpasscode", sender: self)
            print("Mobile: \(phoneNumberString)")
        }
    }
    
    // Create User Function
    func createNewUser(phoneNumber: String) {
        var signUpData: [String : Any] = [:]

        signUpData["mobile"] = phoneNumber
      
    }
    
    
    // MARK: used for viewing end and editing when touches view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func textFieldDidChange(_ sender: HoshiTextField) {
       
        if sender == self.phoneNumberTextField {
            
            if self.isValidMobile() {
                self.validate = true
               
            } else if sender == self.phoneNumberTextField {
                //Convert
                let lastText = sender.text
                sender.text = lastText!.format("nnnn nnn nnn nnn nnn nnn", oldString: lastText!)
                if self.isValidMobile() {
                    self.phoneNumberLabelError.isHidden = true
                }
            }
            
            if self.isValidMobile(){
                self.validate = true }
                    else {
                
                self.validate = false
                    }
                }
            }
    


    // Validtion (WIP) for mobile number (brett)
  //  func isValidMobile() -> Bool {
        
        
        
   //    if phoneNumberTextField.text!.count > 9 {
  //          return true
  //      } else {
  //          return false
  //      }
  //  }

    
    // NEW One from Wang
    //MARK: Checking total mobile number validation(phone number validation and 10 < phone number string count < 12)
    func isValidMobile() -> Bool {
        let unformat = self.phoneNumberTextField.text!.unformat("nnnn nnn nnn nnn nnn nnn", oldString: self.phoneNumberTextField.text!)
        let real_num = "+" + unformat
        
        if self.isValidPhoneNumber(value: real_num) {
            
            if String(unformat).count > 9 && String(unformat).count < 16 {
                
                return true
            }else {
                return false
            }
        }else {
            return false
        }
    }
    
    
    
    // MARK: for intialization for errors
    func Initialize() {
        self.continueButton.fillColor = UIColor.lightGray
        
        phoneNumberTextField.delegate = self
        
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
        
        } else {
            print("error")
        }
    }
    
}

// MARK: UITextFieldDelegate Methods

extension welcomeViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.phoneNumberTextField {
            
            if textField.text == "" {
                
                self.phoneNumberLabelError.text = "This field is required."
                self.phoneNumberLabelError.isHidden = false
                
                return
            }
            
            else if String(textField.text!).count < 7 {
                
                self.phoneNumberLabelError.text = "Invalid Phone Number."
                self.phoneNumberLabelError.isHidden = false
                self.phoneNumberLabelError.textColor = UIColor.red
                
                return
                
            }
            else if String(textField.text!).count > 12 {
                
                self.phoneNumberLabelError.text = "Invalid Phone Number."
                self.phoneNumberLabelError.isHidden = false
                self.phoneNumberLabelError.textColor = UIColor.red
                
                return
            }
                
            else if textField == self.phoneNumberTextField {
                
                let unformat = self.phoneNumberTextField.text!.unformat("nnnn nnn nnn nnn nnn nnn nnn nnn", oldString: self.phoneNumberTextField.text!)
                
                if unformat == "" {
                    
                   
                    self.phoneNumberLabelError.isHidden = false
                    self.phoneNumberLabelError.text = "This field is required."
                    self.phoneNumberLabelError.textColor = UIColor.red
                    
                    return
                
            }
                else if String(unformat).count < 10 {
                    
                   
                    self.phoneNumberLabelError.isHidden = false
                    self.phoneNumberLabelError.text = "Invalid Mobile Number. You need at least 9 characters."
                    self.phoneNumberLabelError.textColor = UIColor.red
                    
                    return
                    
                }else if String(unformat).count > 15 {
                    
                
                    self.phoneNumberLabelError.isHidden = false
                    self.phoneNumberLabelError.text = "Invalid Mobile Number. You need less than 12 characters."
                    self.phoneNumberLabelError.textColor = UIColor.red
                    
                    return
                    
                }
                
                let real_num = "+" + unformat
                print("unformat : \(real_num)")
                if !self.isValidPhoneNumber(value: real_num) {
                    
                    print("string contains special characters")
                 
                    self.phoneNumberLabelError.isHidden = false
                    self.phoneNumberLabelError.text = "Invalid Mobile Number. You must input correct mobile number."
                    self.phoneNumberLabelError.textColor = UIColor.red
                }
            
           
            
            else if textField == self.phoneNumberTextField {
                
    
                
                return
                }
            }
        }
    }
}
