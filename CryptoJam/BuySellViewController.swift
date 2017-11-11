//
//  BuySellViewController.swift
//  CryptoJam
//
//  Created by Teddy Kitchen on 10/23/17.
//  Copyright © 2017 Teddy Kitchen. All rights reserved.
//

import Foundation
import UIKit

class BuySellViewController: ViewController {
    
    override func viewDidLoad() {

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
    }

    
    
    @IBAction func enterMaxValue(_ sender: AnyObject) {
    }
    
    
    func setBuyMode(){
        executeTxn.setTitle("Buy", for: UIControlState.normal)
        print("BUY MODE")
    }
    
    func setSellMode(){
        executeTxn.setTitle("Sell", for: UIControlState.normal)
        print("SELL MODE")
    }
    
    override func dataReady(manager: WebDataManager) {
        print("dataReady in buy sell view controller")
    }
    
    
}
