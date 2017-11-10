//
//  TransactionHandler.swift
//  CryptoJam
//
//  Created by Teddy Kitchen on 10/23/17.
//  Copyright © 2017 Teddy Kitchen. All rights reserved.
//

import Foundation


//define constants for user default keys
let CURRENT_FUNDS = "currentFunds"
let ETHER_BALANCE = "etherBalance"
let DOLLARS_ADDED = "dollarsAdded"

class TransactionHandler {
    

    func buyEther(){
        
    }
    
    func addDollars(amount: Double){
        let defaults = UserDefaults()
        //set current dollars amount
        let existingFunds = defaults.double(forKey: CURRENT_FUNDS)
        defaults.set(amount + existingFunds, forKey: CURRENT_FUNDS)
        //set current dollar
        let existingDollarsAdded = defaults.double(forKey: DOLLARS_ADDED)
        defaults.set(amount + existingDollarsAdded, forKey: DOLLARS_ADDED)
    }
    
    func sellEth(){
        
    }
    
}
