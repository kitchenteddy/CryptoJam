//
//  PriceDisplayViewController.swift
//  CryptoJam
//
//  Created by Teddy Kitchen on 10/23/17.
//  Copyright © 2017 Teddy Kitchen. All rights reserved.
//

import Foundation
import UIKit



class PriceDisplayViewController: ViewController, WebManagerDelegate {
    
    var dataManager: WebDataManager?
    

    @IBOutlet weak var ethPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataManager = WebDataManager(delegate: self)
        //_ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.dataManager!.startUrlSession), userInfo: nil, repeats: true)
        self.dataManager!.startUrlSession()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
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
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let price = dataManager?.ethPrice {
            print(price)
        } else {
            print("ethPrice is nil")
        }
        if (dataManager == nil){
            print("data manager not initialized")
        }
    }
    
    
    
    
}
