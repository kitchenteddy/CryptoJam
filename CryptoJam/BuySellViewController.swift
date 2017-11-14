//
//  BuySellViewController.swift
//  CryptoJam
//
//  Created by Teddy Kitchen on 10/23/17.
//  Copyright © 2017 Teddy Kitchen. All rights reserved.
//

import Foundation
import UIKit

class BuySellViewController: ViewController, UITextFieldDelegate  {
    
    var updateTimer = Timer()
    var ethPrice: Double?
    
    //txnAmt = Integer describing how many cents are entered.  ie 357 = $3.57
    var txnAmt: Int = 0
    
    override func viewDidLoad() {
        amountField.delegate = self
        amountField.placeholder = updateTxnAmount()
        amountField.keyboardType = UIKeyboardType.decimalPad
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear")
        startDataImport()
        startUpdatingPriceData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("view did disappear")
        stopUpdatingPriceData()
    }
    
    
    @IBOutlet weak var buySellSegmentedControl: UISegmentedControl!
    
    @IBAction func buySellSegmentedAction(_ sender: AnyObject) {
        if(buySellSegmentedControl.selectedSegmentIndex == 0){
            setBuyMode()
        } else if(buySellSegmentedControl.selectedSegmentIndex == 1){
            setSellMode()
        }
    }
    
    @IBOutlet weak var txnLabel: UILabel!
    
    
    @IBOutlet weak var holdingsLabel: UILabel!
  
    
    @IBOutlet weak var executeTxn: UIButton!
    
    @IBAction func executeTxn(_ sender: AnyObject) {
        let handler = TransactionHandler()
        
        guard let price = ethPrice else {
            print("no eth price")
            return
        }
        
        let refreshAlert = UIAlertController(title: "Confirmation", message: "All data will be lost.", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            let answer = handler.buyEther(enteredAmount: self.txnAmt, price: price)
            if (!answer){
                print("insuficient Funds")
            }
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            return
        }))
        txnAmt = 0
        amountField.text = updateTxnAmount()
        present(refreshAlert, animated: true, completion: nil)
    }

    
    @IBAction func enterMaxValue(_ sender: AnyObject) {
        //IMPLEMENT
    }
    
    @IBOutlet weak var amountField: UITextField!

    @IBAction func userTappedBackgroundWithSender(_ sender: AnyObject) {
        
        print("USER TAPPED BACKGROUND")
        view.endEditing(true)
    }
    
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String)
        -> Bool{
            
            if let digit = Int(string){
                
                if (txnAmt>999999999){
                    amountField.text = updateTxnAmount()
                    return false
                }
                txnAmt = txnAmt * 10 + digit
                amountField.text = updateTxnAmount()
            }
            if string == "" {
                print("DELETE PRESSED")
                txnAmt = txnAmt / 10
                amountField.text = updateTxnAmount()
            }
            return false
    }
    
    func updateTxnAmount() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        let amount = Double(txnAmt/100) + Double(txnAmt%100)/100
        return formatter.string(from: NSNumber(value: amount))
    }
    
    //
    //TIMER FUNCTIONS
    //
    func stopUpdatingPriceData(){
        updateTimer.invalidate()
    }
    
    func startUpdatingPriceData(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        updateTimer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(self.startDataImport), userInfo: nil, repeats: true)
    }
    
    
    //Make changes
    func setBuyMode(){
        executeTxn.setTitle("Buy", for: UIControlState.normal)
        print("BUY MODE")
    }
    
    func setSellMode(){
        executeTxn.setTitle("Sell", for: UIControlState.normal)
        print("SELL MODE")
    }
    
    
    //Must Implement for WebManagerDelegate
    override func dataReady(manager: WebDataManager) {
        //Update labels etc.
        guard let price = manager.ethPrice else{
            return
        }
        ethPrice = price
        txnLabel.text = "Buy or sell Ether for \(price) each"
        print("dataReady in buy sell view controller")
    }
    

    
    
    
}
