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
    
    //var dataManager: WebDataManager?
    
    @IBOutlet weak var ethPriceLabel: UILabel!
    var updateTimer = Timer()

    @IBOutlet weak var btcPriceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startDataImport()
        startUpdatingPriceData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stopUpdatingPriceData()
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
    
    //
    //Responds to data being ready for display
    override func dataReady(manager: WebDataManager) {
        print(manager.ethPrice)
        if let ethPrice = manager.ethPrice{
            ethPriceLabel.text = ("1 ETH = $\(ethPrice)")
        }
        if let btcPrice = manager.btcPrice{
            btcPriceLabel.text = ("1 BTC = $\(btcPrice)")
        }
        
        print("price is nil")
    }

    func textField(textField: UITextField,
                   shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String)
        -> Bool{
            return true
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let dataManager = WebDataManager(delegate: self)
        guard let price = dataManager.ethPrice else {
            print("ethPrice is nil")
            return
        }
        print(price)
    }
}
