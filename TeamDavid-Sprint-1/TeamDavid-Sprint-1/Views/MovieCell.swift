//
//  MovieCell.swift
//  TeamDavid-Sprint-1
//
//  Created by David Doswell on 12/15/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieLabel: UILabel!
    
    @IBOutlet weak var toggleButton: UIButton!

    @IBAction func toggleButton(_ sender: Any) {
        updateViews()
    }
    
    private func updateViews() {
        if toggleButton.currentTitle == "Not seen" {
            toggleButton.setTitle("Seen", for: .normal)
        } else {
            toggleButton.setTitle("Not seen", for: .normal)
        }
    }
    
}
