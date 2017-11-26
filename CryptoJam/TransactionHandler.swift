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
    func buySellEther(enteredAmount: Int, price: Double) -> Bool{
        let defaults = UserDefaults()
        let currentFunds = defaults.integer(forKey: CURRENT_FUNDS)
        
        print("entered amount = \(enteredAmount)")
        print("current funds = \(currentFunds)")
        
        let newDollarBalance = currentFunds - enteredAmount
        let etherBalance = defaults.double(forKey: ETHER_BALANCE)
        let dollarsEntered = Double(enteredAmount)/100.0
        let toAdd =  Double(dollarsEntered)/price
        let newEtherBalance = etherBalance + toAdd
        
        //if we do not have enough dollars or ether, reject the transaction
        if(newDollarBalance < 0 || newEtherBalance < 0){
            return false
        } else {
            
            defaults.set(newDollarBalance, forKey: CURRENT_FUNDS)
            
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
    
    func getCurrentFunds() -> Int {
        let defaults = UserDefaults()
        return defaults.integer(forKey: CURRENT_FUNDS)
    }
    
    func getEtherBalance() -> Double{
        let defaults = UserDefaults()
        return defaults.double(forKey: ETHER_BALANCE)
    }
    
    func getDollarsAdded() -> Double{
        let defaults = UserDefaults()
        return defaults.double(forKey: DOLLARS_ADDED)
    }
    
}
