//
//  ViewController.swift
//  CryptoJam
//
//  Created by Teddy Kitchen on 10/13/17.
//  Copyright © 2017 Teddy Kitchen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WebManagerDelegate{

    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //Begins the URLSession to import our price data
    func startDataImport(){
        let dataManager = WebDataManager(delegate: self)
        dataManager.startUrlSession()
        print("data import started")
    }
    
    
    //Since this class conforms to
    func dataReady(manager: WebDataManager) {
        preconditionFailure("This method must be overridden")
    }
}






