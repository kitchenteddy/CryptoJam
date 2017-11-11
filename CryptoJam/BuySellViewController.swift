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
    
    override func viewDidLoad() {
        amountField.delegate = self
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
  
    
    @IBOutlet weak var executeTxn: UIButton!
    
    @IBAction func executeTxn(_ sender: AnyObject) {
        let refreshAlert = UIAlertController(title: "Refresh", message: "All data will be lost.", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
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
        txnLabel.text = "Buy or sell Ether for \(price) each"
        print("dataReady in buy sell view controller")
    }
    

    
    
    
}
