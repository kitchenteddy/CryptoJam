//
//  PriceDisplayViewController.swift
//  CryptoJam
//
//  Created by Teddy Kitchen on 10/23/17.
//  Copyright © 2017 Teddy Kitchen. All rights reserved.
//

import Foundation
import UIKit



class PriceDisplayViewController: ViewController {
    
    
    

    @IBOutlet weak var ethPriceLabel: UILabel!
    
    override func dataReady() {
        
        print(dataManager?.ethPrice)
        if let price = dataManager?.ethPrice{
            ethPriceLabel.text = ("1 ETH = \(price)")
            
        } else {
            print("price is nil")
        }
        
    }
    
    
    

    
    func textField(textField: UITextField,
                   shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String)
        -> Bool{
            return true
    }
    
    
    
    
    
    
}
