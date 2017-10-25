//
//  AddMoneyViewController.swift
//  CryptoJam
//
//  Created by Teddy Kitchen on 10/23/17.
//  Copyright © 2017 Teddy Kitchen. All rights reserved.
//

import Foundation
import UIKit
class AddMoneyViewController: ViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        AddMoneyTextField.delegate = self
        AddMoneyTextField.keyboardType = UIKeyboardType.decimalPad
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String)
        -> Bool{
            
            // Check to see if the text field's contents still fit the constraints
            // with the new content added to it.
            // If the contents still fit the constraints, allow the change
            // by returning true; otherwise disallow the change by returning false.
            if string.characters.count == 0 {
                return true
            }
            let currentNsString = textField.text as NSString?
    
            guard let prospectiveText = currentNsString?.replacingCharacters(in: range, with: string) else {return true}

            let decimalSeparator = NSLocale.current.decimalSeparator ?? "."
        
            
            return prospectiveText.isNumeric() &&
                    prospectiveText.doesNotContainCharactersIn(matchCharacters: "-e" + decimalSeparator) &&
                    prospectiveText.characters.count <= 8
    }
    
    @IBOutlet weak var AddMoneyTextField: UITextField!
    
    @IBAction func userTappedBackground(sender: AnyObject) {
        print("USER TAPPED BACKGROUND")
        view.endEditing(true)
    }
    
    override func dataReady() {
        print("dataReady in add money view controller")
    }

}
