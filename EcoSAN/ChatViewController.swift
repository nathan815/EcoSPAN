//
//  ChatViewController.swift
//  EcoSAN
//
//  Created by Nathaniel Johnson on 1/20/18.
//  Copyright © 2018 spartahack18. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Foundation

class ChatViewController: JSQMessagesViewController {
    
    
    var messages = [JSQMessage]()
    let chatService = ChatServiceManager.getInstance()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    @IBOutlet weak var connectedPeers: UILabel!
    
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }()
    
    lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleGreen())
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        chatService!.delegate = self
        senderId = UIDevice.current.identifierForVendor?.uuidString
        senderDisplayName = "Anonymous"
        self.edgesForExtendedLayout = []
        inputToolbar.contentView.leftBarButtonItem = nil
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        promptForName()
        
    }
    
    func promptForName() {
        let alert = UIAlertController(title: "Display Name", message: "Enter a display name", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            self.senderDisplayName = (alert?.textFields![0])!.text! // Force unwrapping because we know it exists.
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData!
    {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource!
    {
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!
    {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString!
    {
        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat
    {
        return messages[indexPath.item].senderId == senderId ? 0 : 15
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!)
    {
        if let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        {
            self.messages.append(message)
            print("SENDING:",message.text)
            chatService!.send(d: senderId+"::"+senderDisplayName+"::"+text)
            
        }
        finishSendingMessage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ChatViewController : ChatServiceManagerDelegate {
    
    func connectedDevicesChanged(manager: ChatServiceManager, connectedDevices: [String]?) {
        OperationQueue.main.addOperation {
            self.connectedPeers.text = "Connected: " + String(connectedDevices!.count ?? 0)
            print("Connections: \(connectedDevices ?? [])")
        }
    }
    
    func chatChanged(manager: ChatServiceManager, d: String) {
        OperationQueue.main.addOperation {
            let data = d.components(separatedBy: "::")
            let message = JSQMessage(senderId: data[0], displayName: data[1], text: data[2])
            self.messages.append(message!)
            print("RECIEVING:",message!.text)
            self.finishSendingMessage()
        }
    }
    
}

