//
//  RandomUserDetailViewController.swift
//  TeamDavid-Sprint-5
//
//  Created by David Doswell on 12/23/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class RandomUserDetailViewController: UIViewController {
    
    var randomUser: RandomUser?
    let userFetchQueue = OperationQueue()
    
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let randomUser = randomUser else { return }
        
        let fetchOperation = FetchImageOperation(randomUser: randomUser, imageType: .large)
        let blockOperation = BlockOperation {
            guard let image = fetchOperation.image else { return }
            self.imageView.image = image
        }
        
        blockOperation.addDependency(fetchOperation)
        
        userFetchQueue.addOperation(fetchOperation)
        OperationQueue.main.addOperation(blockOperation)
        
        nameLabel.text = randomUser.name
        phoneNumberLabel.text = randomUser.phoneNumber
        emailLabel.text = randomUser.emailAddress
    }
    
}

