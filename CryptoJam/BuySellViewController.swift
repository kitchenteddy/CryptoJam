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
    var ethBalance: Double?
    var mode: TransactionType = .buy
    
    
    //txnAmt = Integer describing how many cents are entered.  ie 357 = $3.57
    var txnAmt: Int = 0
    
    override func viewDidLoad() {
        amountField.delegate = self
        amountField.placeholder = updateTxnAmount()
        amountField.keyboardType = UIKeyboardType.decimalPad
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startDataImport()
        setCurrentBalanceDisplay()
        startUpdatingPriceData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
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
        print("Pre Executed self.txnAmt = \(self.txnAmt)")
        
        let handler = TransactionHandler()
        
        guard let price = ethPrice else {
            print("no eth price for Action: executeTxn")
            return
        }
        
        let failureAlert = UIAlertController(title: "Error", message: "Insufficient Funds for Transaction", preferredStyle: UIAlertControllerStyle.alert)
        failureAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("txn failed due to insufficient funds")
        }))
        
        
        let transactionAlert = UIAlertController(title: "Confirmation", message: "Purchase ethereum for the indicated price?", preferredStyle: UIAlertControllerStyle.alert)
        
        transactionAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            switch self.mode{
            case .buy:
                print("buy transaction")
            case.sell:
                print("sell transaction")
                self.txnAmt = self.txnAmt * -1
            }
            
            
            print("Executed self.txnAmt = \(self.txnAmt)")
            let answer = handler.buySellEther(enteredAmount: self.txnAmt, price: price)
            if (!answer){
                //present another dialog
                self.present(failureAlert, animated: true, completion: nil)
                print("insuficient Funds for transaction")
            }
            self.txnAmt = 0
            self.amountField.text = self.updateTxnAmount()
            self.setCurrentBalanceDisplay()
            
        }))
        
        transactionAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            return
        }))
        
        self.present(transactionAlert, animated: true, completion: nil)
        
    }
    

    
    @IBAction func enterMaxValue(_ sender: AnyObject) {
        self.txnAmt = getMaxTxnAmount()
        amountField.text = updateTxnAmount()
    }
    
    @IBOutlet weak var amountField: UITextField!

    @IBAction func userTappedBackgroundWithSender(_ sender: AnyObject) {
        
        print("Background tapped self.txnAmt = \(self.txnAmt)")
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
        self.mode = .buy
        executeTxn.setTitle("Buy", for: UIControlState.normal)
        print("BUY MODE")
    }
    
    func setSellMode(){
        self.mode = .sell
        executeTxn.setTitle("Sell", for: UIControlState.normal)
        print("SELL MODE")
    }
    
    
    //Must Implement for WebManagerDelegate
    override func dataReady(manager: WebDataManager) {
        //Update labels etc.
        guard let price = manager.ethPrice else{
            return
        }
        self.ethPrice = price
        txnLabel.text = "Buy or sell Ether for $\(price) each"
        print("dataReady in buy sell view controller")
        setCurrentBalanceDisplay()
    }
    

    func getMaxTxnAmount() -> Int {
        let handler = TransactionHandler()
        switch self.mode{
        case .buy:
            // return available funds
            return handler.getCurrentFunds()
        case .sell:
            if let rate = self.ethPrice{
                let ether = handler.getEtherBalance()
                let toReturn = Int(ether * rate * 100)
                return toReturn
            } else {
                
                
                return 0
            }
            
        }
    }
    
    func setCurrentBalanceDisplay() {
        
        
        let txnHandler = TransactionHandler()
        let current = txnHandler.getEtherBalance()
        print("ETHER BALANCE = \(current)")
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        //formatter.numberStyle = .currency
        if let formattedAmount = formatter.string(from: current as NSNumber) {
            guard let ethRate = self.ethPrice else {
                holdingsLabel.text = "\(formattedAmount) ETH"
                return
            }
            let ethValue = current * ethRate
            formatter.numberStyle = .currency
            if let formattedEthValue = formatter.string(from: ethValue as NSNumber){
                holdingsLabel.text = "\(formattedAmount) ETH = \(formattedEthValue)"
            }
        }
    }
    
    //Enumeration to determine what mode we are in
    enum TransactionType {
        case buy
        case sell
    }
    
    
}
