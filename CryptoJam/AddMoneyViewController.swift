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
    
    //txnAmt = Integer describing how many cents are entered.  ie 357 = $3.57
    var txnAmt: Int = 0
    
    override func viewDidLoad() {
        addMoneyTextField.delegate = self
        addMoneyTextField.keyboardType = UIKeyboardType.decimalPad
        addMoneyTextField.placeholder = updateTxnAmount()
    }
    
    
    override func viewDidAppear(_ animated: Bool){
        setCurrentFundsDisplay()
    }
    
    
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String)
        -> Bool{
            
            if let digit = Int(string){
                
                if (txnAmt>999999999){
                    addMoneyTextField.text = updateTxnAmount()
                    return false
                }
                txnAmt = txnAmt * 10 + digit
                addMoneyTextField.text = updateTxnAmount()
            }
            if string == "" {
                //Delete Pressed
                txnAmt = txnAmt / 10
                addMoneyTextField.text = updateTxnAmount()
            }
            return false

    }
    
    
    func updateTxnAmount() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        let amount = Double(txnAmt/100) + Double(txnAmt%100)/100
        return formatter.string(from: NSNumber(value: amount))
    }

    @IBOutlet weak var addMoneyTextField: UITextField!
    
    @IBOutlet weak var currentFundsTextField: UILabel!
    
    @IBAction func userTappedBackground(sender: AnyObject) {
        print("USER TAPPED BACKGROUND")
        view.endEditing(true)
    }
    
    @IBAction func addFunds(_ sender: AnyObject) {
        
        
        let amount = txnAmt
        let txnHandler = TransactionHandler()
        txnHandler.addDollars(amount: amount)
        addMoneyTextField.text = ""
        txnAmt = 0
        setCurrentFundsDisplay()
        
        
    }
    
    @IBAction func resetAllFunds(_ sender: Any) {
        let txnHandler = TransactionHandler()
        txnHandler.resetAllFunds()
        setCurrentFundsDisplay()
         
    }
    
    func setCurrentFundsDisplay() {
        
        let defaults = UserDefaults()
        let currentFunds = defaults.double(forKey: "currentFunds") / 100 //integer stored is value in cents, convert it to dollars
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let formattedAmount = formatter.string(from: currentFunds as NSNumber) {
            currentFundsTextField.text = formattedAmount
        }
    }
    
    
    override func dataReady(manager: WebDataManager) {
        print("dataReady in add money view controller")
    }

}
