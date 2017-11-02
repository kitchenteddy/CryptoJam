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
        addMoneyTextField.delegate = self
        addMoneyTextField.keyboardType = UIKeyboardType.decimalPad
        setCurrentFundsDisplay()
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
    

    @IBOutlet weak var addMoneyTextField: UITextField!
    
    @IBOutlet weak var currentFundsTextField: UILabel!
    
    @IBAction func userTappedBackground(sender: AnyObject) {
        print("USER TAPPED BACKGROUND")
        view.endEditing(true)
    }
    
    @IBAction func addFunds(_ sender: AnyObject) {
        guard let rawText = addMoneyTextField.text else{
            print("no text")
            return
        }
        
        guard let amount = Double(rawText) else {
            print("text is invalid double")
            return
        }
        
        
        let defaults = UserDefaults()
        let existingFunds = defaults.double(forKey: "currentFunds")
        defaults.set(amount + existingFunds, forKey: "currentFunds")
        print("Current Funds: \(defaults.double(forKey: "currentFunds"))")
        addMoneyTextField.text = ""
        
        
        setCurrentFundsDisplay()
        
    }
    
    
    func setCurrentFundsDisplay() {
        
        let defaults = UserDefaults()
        let currentFunds = defaults.double(forKey: "currentFunds")
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: currentFunds as NSNumber) {
            currentFundsTextField.text = formattedTipAmount
        }
    }
    
    
    override func dataReady() {
        print("dataReady in add money view controller")
    }

}
