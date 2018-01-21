//
//  FirstViewController.swift
//  EcoSAN
//
//  Created by Nathaniel Johnson on 1/20/18.
//  Copyright © 2018 spartahack18. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LeaderboardViewController: UIViewController {

    @IBOutlet weak var leaderboard: UITextView!
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    var resp = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.leaderboard.text = ""
        Alamofire.request("http://ecosan.azurewebsites.net/api/trashpickup/LeaderboardsAll").responseJSON { response in
            if let result = response.result.value {
                let json = JSON(result)
                for x in json["Rows"].arrayValue {
                    self.leaderboard.insertText("Name: " + x.arrayValue[2].rawString()! + " | Points: " + x.arrayValue[0].rawString()! + " | Pickups: " + x.arrayValue[1].rawString()! + "\n")
                }
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

