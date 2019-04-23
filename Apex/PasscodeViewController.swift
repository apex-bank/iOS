//
//  PasscodeViewController.swift
//  Apex
//
//  Created by Brett Hales on 4/10/19.
//  Copyright © 2019 Brett Hales. All rights reserved.
//

import Foundation
import UIKit

struct passCodeKeyStruct {
    
    var status : Int
    var title : String
    var value : String
}

class passcodeViewController: UIViewController {
    
    //Data for the numberpad
    let passCodeKeyData : [passCodeKeyStruct] = [
        passCodeKeyStruct(status: 0, title: "1", value: "1"),
        passCodeKeyStruct(status: 0, title: "2", value: "2"),
        passCodeKeyStruct(status: 0, title: "3", value: "3"),
        passCodeKeyStruct(status: 0, title: "4", value: "4"),
        passCodeKeyStruct(status: 0, title: "5", value: "5"),
        passCodeKeyStruct(status: 0, title: "6", value: "6"),
        passCodeKeyStruct(status: 0, title: "7", value: "7"),
        passCodeKeyStruct(status: 0, title: "8", value: "8"),
        passCodeKeyStruct(status: 0, title: "9", value: "9"),
        passCodeKeyStruct(status: 1, title: "Forgot", value: "Forgot"),
        passCodeKeyStruct(status: 0, title: "0", value: "0"),
        passCodeKeyStruct(status: 2, title: "Delete", value: "Delete"),
        ]
    
    var inputPassCode : [String] = []

    
    let PasscodeNumberPadCollectionViewCell = "PasscodeNumberPadCollectionViewCell"
    let PasscodeNumberPadTextCollectionViewCell = "PasscodeNumberPadTextCollectionViewCell"

    
    // Outlets
    @IBOutlet weak var passcodeLabel: UILabel!
    @IBOutlet weak var passcodeCollectionView: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var passcode1: UIView!
    @IBOutlet weak var passcode2: UIView!
    @IBOutlet weak var passcode3: UIView!
    @IBOutlet weak var passcode4: UIView!
    
    private func setupKeycodeView(){
        
        self.passcode1.layer.cornerRadius = 10
        self.passcode1.backgroundColor = UIColor.deepSkyBlue25
        self.passcode2.layer.cornerRadius = 10
        self.passcode2.backgroundColor = UIColor.deepSkyBlue25
        self.passcode3.layer.cornerRadius = 10
        self.passcode3.backgroundColor = UIColor.deepSkyBlue25
        self.passcode4.layer.cornerRadius = 10
        self.passcode4.backgroundColor = UIColor.deepSkyBlue25
    }
    
    /**
    upload users info
     if the phone number information is recieved, then
     - phoneNumber: from WelcomeViewController as the users phone number
     - pincode: from user entry
 
 */
    
    
    
    private func setupCollectionView(){
    self.passcodeCollectionView.register(UINib(nibName:self.PasscodeNumberPadCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: self.PasscodeNumberPadCollectionViewCell)
    self.passcodeCollectionView.register(UINib(nibName:self.PasscodeNumberPadTextCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: self.PasscodeNumberPadTextCollectionViewCell)
    
    
     //   self.passcodeCollectionView.datasource = self
        self.passcodeCollectionView.delegate = self
    
    }
    
    func clearInputKeycodeView(){
    
  //  self.inputPassCode = []
    
    self.inputPassCode = []
    self.setupKeycodeView()
    
    }
    
    func inputPassCodeAction() {
        
       self.setupKeycodeView()
        
        if(self.inputPassCode.count == 1){
            self.passcode1.layer.cornerRadius = 10
            self.passcode1.backgroundColor = UIColor.deepSkyBlue
        }
        if(self.inputPassCode.count == 2){
            self.passcode1.backgroundColor = UIColor.deepSkyBlue
            self.passcode2.backgroundColor = UIColor.deepSkyBlue
            
        }
        if(self.inputPassCode.count == 3){
            self.passcode1.backgroundColor = UIColor.deepSkyBlue
            self.passcode2.backgroundColor = UIColor.deepSkyBlue
            self.passcode3.backgroundColor = UIColor.deepSkyBlue
            
        }
        if(self.inputPassCode.count == 4){
            self.passcode1.backgroundColor = UIColor.deepSkyBlue
            self.passcode2.backgroundColor = UIColor.deepSkyBlue
            self.passcode3.backgroundColor = UIColor.deepSkyBlue
            self.passcode4.backgroundColor = UIColor.deepSkyBlue
            
        }
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.clearInputKeycodeView()
        self.setupCollectionView()
        
    }
}





extension passcodeViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return self.passCodeKeyData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
     
        let data = self.passCodeKeyData[indexPath.row]
        
        if(data.status == 0) {
            
            // For NumberPad cells (numbers)
            let numCell = collectionView.dequeueReusableCell(withReuseIdentifier: PasscodeNumberPadCollectionViewCell, for: indexPath) as! PasscodeNumberPadCollectionViewCell
            
            numCell.setupCell(title: data.title)
            
            return numCell
            
        }
        
       
        // For Numberpad Text (i.e. Forgot PIN?)
        let textCell = collectionView.dequeueReusableCell(withReuseIdentifier: PasscodeNumberPadTextCollectionViewCell, for: indexPath) as! PasscodeNumberPadTextCollectionViewCell
        
        textCell.setupCell(title: data.title)
        
        return textCell
        }
    
    // attempt to dispatch the queue
    

    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width / 3
        let height = width
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let data = self.passCodeKeyData[indexPath.row]
        
        if(data.status == 0){
            print(data.value)
            
            self.inputPassCode.append(data.value)
            self.inputPassCodeAction()
            
        }
        else {
            
            if(data.status == 1) {
                print(data.value)
                self.clearInputKeycodeView()
            }
            
            if(data.status == 2) {
                print(data.value)
                if(self.inputPassCode.count > 0){
                    
                    self.inputPassCode.remove(at: inputPassCode.count - 1)
                    
                    self.inputPassCodeAction()
                }
            }
        }
    }
}
