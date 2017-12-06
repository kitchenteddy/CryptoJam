//
//  WebDataManager.swift
//  CryptoJam
//
//  Created by Teddy Kitchen on 10/4/17.
//  Copyright © 2017 Teddy Kitchen. All rights reserved.
//
import Foundation
import SwiftyJSON



//This is a class for creating objects to download and review web data for Crypto Currencies
class WebDataManager: NSObject {
    //
    var data: String?
    var ethPrice: Double?
    var btcPrice: Double?
    var delegate: WebManagerDelegate
    
    
    init(delegate: WebManagerDelegate){
        self.delegate = delegate
    }
    
    
    func startUrlSession(){

        let ephemeralConfiguration = URLSessionConfiguration.ephemeral
        let sessionWithoutADelegate = URLSession(configuration: ephemeralConfiguration)
        if let url = URL(string:"https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH&tsyms=USD,EUR") {
            (sessionWithoutADelegate.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                } else if let _ = response,
                    let info = data,
                    let string = String(data: info, encoding: .utf8) {
                    self.data = string
                    
                    self.setPriceFromData(info: data!)
                    
                    //updating UI must be done from the main thread
                    DispatchQueue.main.async {
                        self.delegate.dataReady(manager: self)
                    }
                    print("DATA:\n\(string)\nEND DATA\n")
                }
            }).resume()
        }
    }
    
    //sets the Price Variables
    func setPriceFromData(info: Data){
        let json = JSON(data: info)
        self.ethPrice = json["ETH"]["USD"].doubleValue
        self.btcPrice = json["BTC"]["USD"].doubleValue
        
    }
    
}
