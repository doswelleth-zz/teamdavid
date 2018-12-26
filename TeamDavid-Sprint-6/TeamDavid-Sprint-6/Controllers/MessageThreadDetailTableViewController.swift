//
//  MessageThreadDetailTableViewController.swift
//  TeamDavid-Sprint-6
//
//  Created by David Doswell on 12/24/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = messageThread?.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThread?.messages.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        
        let message = messageThread?.messages[indexPath.row]
        
        cell.textLabel?.text = message?.messageText
        cell.detailTextLabel?.text = message?.sender
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddMesage" {
            guard let destinationVC = segue.destination as? MessageDetailViewController else { return }
            
            destinationVC.messageThreadController = messageThreadController
            destinationVC.messageThread = messageThread
        }
    }
    
    // MARK: - Properties
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
}
