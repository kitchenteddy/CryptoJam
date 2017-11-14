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
    
//requests an ether transaction based on current price and funds
//returns true if user has sufficient funds and the Txn is executed
//returns false if user has insufficient funds and the Txn is rejected
    func buyEther(enteredAmount: Int, price: Double) -> Bool{
        let defaults = UserDefaults()
        let currentFunds = defaults.integer(forKey: CURRENT_FUNDS)
        if(enteredAmount > currentFunds){
            return false
        } else {
            let newDollarBalance = currentFunds - enteredAmount
            defaults.set(newDollarBalance, forKey: CURRENT_FUNDS)
            let etherBalance = defaults.double(forKey: ETHER_BALANCE)
            let toAdd =  Double(enteredAmount)/price
            let newEtherBalance = etherBalance + toAdd
            defaults.set(newEtherBalance, forKey: ETHER_BALANCE)
            print(newEtherBalance)
            return true
        }
    }
    
    func addDollars(amount: Int){
        let defaults = UserDefaults()
        //set current dollars amount
        let existingFunds = defaults.integer(forKey: CURRENT_FUNDS)
        defaults.set(amount + existingFunds, forKey: CURRENT_FUNDS)
        //set current dollar
        let existingDollarsAdded = defaults.integer(forKey: DOLLARS_ADDED)
        defaults.set(amount + existingDollarsAdded, forKey: DOLLARS_ADDED)
    }
    
    func sellEth(){
        
    }
    
}
