//
//  OTPSMSViewController.swift
//  Apex
//
//  Created by Brett Hales on 4/11/19.
//  Copyright © 2019 Brett Hales. All rights reserved.
//

import Foundation
import UIKit
import TextFieldEffects

class OTPSMSViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var textOTP1: HoshiTextField!
    @IBOutlet weak var textOTP2: HoshiTextField!
    @IBOutlet weak var textOTP3: HoshiTextField!
    @IBOutlet weak var spaceLabel: UIView!
    @IBOutlet weak var textOTP4: HoshiTextField!
    @IBOutlet weak var textOTP5: HoshiTextField!
    @IBOutlet weak var textOTP6: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        self.textOTP1.delegate = self
        self.textOTP2.delegate = self
        self.textOTP3.delegate = self
        self.textOTP4.delegate = self
        self.textOTP5.delegate = self
        self.textOTP6.delegate = self
        
        textOTP1.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((textField.text?.count)! < 1) && (string.count > 0) {
            
            if textField == textOTP1 {
                textOTP2.becomeFirstResponder()
            }
            
            if textField == textOTP2 {
                textOTP3.becomeFirstResponder()
            }
            
            if textField == textOTP3 {
                textOTP4.becomeFirstResponder()
            }
            
            if textField == textOTP4 {
                textOTP5.becomeFirstResponder()
            }
            
            if textField == textOTP5 {
                textOTP6.becomeFirstResponder()
            }
            
            if textField == textOTP6 {
                textOTP6.resignFirstResponder()
            }
            
            textField.text = string
            return false
        } else if ((textField.text?.count)! >= 1) && (string.count == 0) {
            
            if textField == textOTP2 {
                textOTP1.becomeFirstResponder()
            }
            
            if textField == textOTP3 {
                textOTP2.becomeFirstResponder()
            }
            
            if textField == textOTP4 {
                textOTP3.becomeFirstResponder()
            }
            
            if textField == textOTP5 {
                textOTP4.becomeFirstResponder()
            }
            
            if textField == textOTP6 {
                textOTP5.becomeFirstResponder()
            }
            
            if textField == textOTP1 {
                textOTP1.resignFirstResponder()
            }
         textField.text = ""
            
            return false
        } else if (textField.text?.count)! >= 1 {
            textField.text = string
            return false
            
        }
        
        return true
        }
}
