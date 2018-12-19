//
//  EntryTableViewCell.swift
//  JournalWeekend
//
//  Created by Lambda-School-Loaner-11 on 12/19/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var bodyText: UILabel!
    
    @IBOutlet weak var timestamp: UILabel!
    
    // MARK: - Function that takes the values from the entry variable and places them in the outlets
    
    private func updateViews() {
        
        guard let entry = entry else { return }

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        let date = dateFormatter.string(from: entry.timestamp!)

        self.titleLabel.text = entry.title
        self.bodyText.text = entry.bodyText
        self.timestamp.text = date
    }
}
