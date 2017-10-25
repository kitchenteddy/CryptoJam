//
//  ViewController.swift
//  CryptoJam
//
//  Created by Teddy Kitchen on 10/13/17.
//  Copyright © 2017 Teddy Kitchen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WebManagerDelegate {

    var dataManager: WebDataManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataManager = WebDataManager(delegate: self)
        //_ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.dataManager!.startUrlSession), userInfo: nil, repeats: true)
        self.dataManager!.startUrlSession()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dataReady() {
        preconditionFailure("This method must be overridden")
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






