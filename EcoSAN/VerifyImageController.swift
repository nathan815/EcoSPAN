//
//  VerifyImageController.swift
//  EcoSAN
//
//  Created by Nathaniel Johnson on 1/20/18.
//  Copyright © 2018 spartahack18. All rights reserved.
//

import UIKit
import Alamofire

class VerifyImageController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    static var imageView: UIImageView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        loadingIndicator.startAnimating();
        verifyImage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func verifyImage() {
        let imageData = UIImageJPEGRepresentation(TrashViewController.chosenImage, 1.0)
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache"
        ]
        let uuid = UUID().uuidString
        let parameters = [
            "Latitude": 0,
            "Longitude": 0,
            "Image": imageData?.base64EncodedString() as Any,
            "DeviceID": uuid as Any,
            "DeviceName": ChatServiceManager.getInstance()?.displayName as Any,
            "ConnectedDevices": [1, 2, 3, 4]
        ] as [String : Any]
        
        Alamofire.request("http://ecosan.azurewebsites.net/api/trashpickup", method: .post, parameters: parameters, encoding: JSONEncoding(options: [])).responseJSON { response in
            let result = response.result.value!
            print(result)
            self.dismiss(animated:true, completion: nil)
            
            if result as! String == "true" {
                self.success()
            } else {
                self.error()
            }
        }
    }
    
    func success() {
        let popup : VerifyImageController = self.storyboard?.instantiateViewController(withIdentifier: "successPickup") as! VerifyImageController
        
        let navigationController = UINavigationController(rootViewController: popup)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.present(navigationController, animated: false, completion: nil)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func error() {
        
    }
    
    
}
