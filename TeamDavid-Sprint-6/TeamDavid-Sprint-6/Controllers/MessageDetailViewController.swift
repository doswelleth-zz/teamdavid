//
//  MessageDetailViewController.swift
//  TeamDavid-Sprint-6
//
//  Created by David Doswell on 12/24/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit


class MessageDetailViewController: UIViewController {
    
    // MARK: - Actions
    
    @IBAction func sendMessage(_ sender: Any) {
        
        guard let senderName = senderNameTextField.text,
            let messageText = messageTextView.text,
            let messageThread = messageThread else { return }
        
        messageThreadController?.createMessage(in: messageThread, withText: messageText, sender: senderName, completion: {
            print("Message created!")
        })
    }
    
    
    // MARK: - Properties
    
    var messageThreadController: MessageThreadController?
    var messageThread: MessageThread?
    
    
    @IBOutlet weak var senderNameTextField: UITextField!
    
    @IBOutlet weak var messageTextView: UITextView!
}
