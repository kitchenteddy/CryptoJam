//
//  StatisticsViewController.swift
//  CryptoJam
//
//  Created by Teddy Kitchen on 10/23/17.
//  Copyright © 2017 Teddy Kitchen. All rights reserved.
//

import Foundation
import UIKit

class StatisticsViewController: ViewController {
    var ethPrice: Double?
    var btcPrice: Double?
    
    override func viewDidAppear(_ animated: Bool) {
        startDataImport()
        setDisplay()
        
    }
    
    
    
    override func dataReady(manager: WebDataManager) {
        ethPrice = manager.ethPrice
        btcPrice = manager.btcPrice
        setDisplay()
        print("DataReadyCalled")
        
    }
    
    func setDisplay(){
        let principal = getDollarsAdded()
        principalLabel.text = ("Principal = $\(principal)")
        netWorthLabel.text = ("Portfolio Value = $\(getNetWorth())")
        returnsLabel.text = ("Returns = \(getReturnsPercentage())%")
    
    }
    
    func getReturnsPercentage() -> Double{
        guard let _ = ethPrice else {
            return 0.00
        }
        let netWorth = getNetWorth()
        let dollarsAdded = getDollarsAdded()
        let changeRatio = netWorth/dollarsAdded
        let percent = round(((changeRatio-1)*100)*100)/100
        return percent
    }
    
    
    
    func getNetWorth() -> Double {
        guard let ethPrice = ethPrice
            else{
                return 0
        }
        let txnHandler = TransactionHandler()
        let ethBalance = round(txnHandler.getEtherBalance()*100)/100
        let currentFunds = Double(txnHandler.getCurrentFunds())/100
        print(ethBalance)
        print(ethPrice)
        print("currentFunds = \(currentFunds)")
        return round((currentFunds + (ethBalance * ethPrice))*100)/100
    }

    
    func getDollarsAdded() -> Double {
        let txnHandler = TransactionHandler()
        return Double(txnHandler.getDollarsAdded())/100
    }
    
    @IBOutlet weak var principalLabel: UILabel!
    
    @IBOutlet weak var netWorthLabel: UILabel!
    
    @IBOutlet weak var returnsLabel: UILabel!
    
    
    
}
