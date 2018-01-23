//
//  MoreViewController.swift
//  EcoSAN
//
//  Created by Nathaniel Johnson on 1/20/18.
//  Copyright © 2018 spartahack18. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url : NSURL! = NSURL(string: "http://ecosan.azurewebsites.net/")
        webView?.loadRequest(NSURLRequest(url: url as URL) as URLRequest)
        webView?.isOpaque = false;
        webView?.backgroundColor = UIColor.clear
        webView?.scalesPageToFit = true;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}


