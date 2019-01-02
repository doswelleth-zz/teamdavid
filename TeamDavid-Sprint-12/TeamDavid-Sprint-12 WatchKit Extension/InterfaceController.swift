//
//  InterfaceController.swift
//  TeamDavid-Sprint-12 WatchKit Extension
//
//  Created by David Doswell on 1/1/19.
//  Copyright © 2019 David Doswell. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        quoteLabel.setText("")
        authorLabel.setText("")
        quoteButton.setEnabled(false)
        
        fetchAQuote()
    }
    
    let quoteController = QuoteController()
    var quote: Quote?
    
    @IBOutlet weak var quoteLabel: WKInterfaceLabel!
    @IBOutlet weak var authorLabel: WKInterfaceLabel!
    @IBOutlet weak var quoteButton: WKInterfaceButton!
    
    private func updateViews() {
        DispatchQueue.main.async {
            self.quoteLabel.setText("\"\(self.quote?.quote ?? "Error fetching your random quote")\"")
            self.authorLabel.setText("\(self.quote?.author ?? "Author unavailable")")
            self.quoteButton.setEnabled(true)
        }
    }
    
    private func fetchAQuote() {
        
        self.quoteButton.setEnabled(false)
        
        quoteController.fetchQuote { (quote, error) in
            
            if let error = error {
                NSLog("Error with fetch: \(error)")
                return
            }
            
            guard let quote = quote else {
                NSLog("Quote was nil")
                return
            }
            
            self.quote = quote
            
            self.updateViews()
        }
    }
    
    @IBAction func fetchNewQuote() {
        fetchAQuote()
    }
}
