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
        passCodeKeyStruct(status: 1, title: "Forgot", value: ""),
        passCodeKeyStruct(status: 0, title: "0", value: "0"),
        passCodeKeyStruct(status: 1, title: "Delete", value: ""),
        ]

    
    let PasscodeNumberPadCollectionViewCell = "PasscodeNumberPadCollectionViewCell"
    let PasscodeNumberPadTextCollectionViewCell = "PasscodeNumberPadTextCollectionViewCell"

    
    // Outlets
    @IBOutlet weak var passcodeLabel: UILabel!
    @IBOutlet weak var passcodeCollectionView: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    
    private func setupCollectionView(){
    self.passcodeCollectionView.register(UINib(nibName:self.PasscodeNumberPadCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: self.PasscodeNumberPadCollectionViewCell)
    self.passcodeCollectionView.register(UINib(nibName:self.PasscodeNumberPadTextCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: self.PasscodeNumberPadTextCollectionViewCell)
    
    
     //  self.passcodeCollectionView.datasource = self
        self.passcodeCollectionView.delegate = self
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width / 3
        let height = width
        
        return CGSize(width: width, height: height)
    }
    
}
