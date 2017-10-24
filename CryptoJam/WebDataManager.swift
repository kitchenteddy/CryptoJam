//
//  WebDataManager.swift
//  CryptoJam
//
//  Created by Teddy Kitchen on 10/4/17.
//  Copyright © 2017 Teddy Kitchen. All rights reserved.
//
import Foundation
import SwiftyJSON

class WebDataManager: NSObject {
    var data: String?
    var ethPrice: Double?
    var delegate: WebManagerDelegate
    
    
    init(delegate: WebManagerDelegate){
        self.delegate = delegate
    }
    
    
    func startUrlSession(){

        let ephemeralConfiguration = URLSessionConfiguration.ephemeral
        

        let sessionWithoutADelegate = URLSession(configuration: ephemeralConfiguration)
        if let url = URL(string:"https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD") {
            (sessionWithoutADelegate.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                } else if let response = response,
                    let info = data,
                    let string = String(data: info, encoding: .utf8) {
                    self.data = string
                    
                    self .setEthPriceFromData(info: data!)
                    
                    
                    self.delegate.dataReady()
                    print("Response: \(response)")
                    print("DATA:\n\(string)\nEND DATA\n")
                }
            }).resume()
        }
        
        //let ephemeralSession = URLSession(configuration: ephemeralConfiguration, delegate: delegate, delegateQueue: operationQueue)

        
    }
    func setEthPriceFromData(info: Data){
        let json = JSON(data: info)
        let usPrice = json["USD"].doubleValue
        self.ethPrice = usPrice
        
    }
    
}
