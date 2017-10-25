//
//  BuySellViewController.swift
//  CryptoJam
//
//  Created by Teddy Kitchen on 10/23/17.
//  Copyright © 2017 Teddy Kitchen. All rights reserved.
//

import Foundation
import UIKit

class BuySellViewController: ViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        moneyAmount.delegate = self
        moneyAmount.keyboardType = UIKeyboardType.decimalPad
    }
    

    @IBOutlet weak var moneyAmount: UITextField!
    
    override func dataReady() {
        print("dataReady in buy sell view controller")
    }
    
    
}
