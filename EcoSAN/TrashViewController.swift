//
//  TrashViewController.swift
//  SecondViewController.swift
//  EcoSAN
//
//  Created by Nathaniel Johnson on 1/20/18.
//  Copyright © 2018 spartahack18. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class TrashViewController: UIViewController,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate  {
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    static var tableView: UITableView!
    static var rows = [String]()
    let chatService = ChatServiceManager.getInstance()
    static var chosenImage: UIImage!

    //MARK: - Outlets
    @IBOutlet weak var previewView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    // Open camera button
    @IBAction func openCameraBtn(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    //MARK: - Delegates
    // When user takes an image and clicks Use
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any])
    {
        TrashViewController.chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let popup : VerifyImageController = self.storyboard?.instantiateViewController(withIdentifier: "verifyTrashImg") as! VerifyImageController
        dismiss(animated:false, completion: nil)
        
        let navigationController = UINavigationController(rootViewController: popup)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.present(navigationController, animated: false, completion: nil)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    // When user cancels
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static func appendTo(displayName : String){
        /*rows.append(displayName)
        tableView.beginUpdates()
        
        let indexPath:IndexPath = IndexPath(row:(self.rows.count), section:0)
        tableView.insertRows(at: [indexPath], with: .left)
        tableView.endUpdates()
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)*/
        
    }


}

