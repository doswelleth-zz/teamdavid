//
//  EntryDetailViewController.swift
//  JournalWeekend
//
//  Created by Lambda-School-Loaner-11 on 12/19/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    var entryController: EntryController!
    
    // MARK: - Outlets
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        guard let title = textField.text, !title.isEmpty else {
            return
        }
        
        // identify the selected segment
        let moodIndex = segmentedControl.selectedSegmentIndex
        
        // select a mood from the array
        let mood = EntryMood.moods[moodIndex]
        
        let body = textView.text
        
        if let entry = entry {
            // updating an entry
            entry.title = title
            entry.mood = mood.rawValue
            entry.bodyText = body
            entryController?.put(entry: entry)
        } else {
            // creating an entry
            let entry = Entry(title: title, bodyText: body!, mood: mood)
            entryController?.put(entry: entry)
        }
        
        // save and persist changes
        do {
            let moc = CoreDataStack.shared.mainContext
            try moc.save()
        } catch {
            NSLog("Error: \(error)")
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        self.title = entry?.title ?? "Create Entry"
        textField.text = entry?.title
        textView.text = entry?.bodyText
        
        guard var mood = EntryMood(rawValue: "") else { return }
        
        if let entryMood = entry?.mood {
            mood = EntryMood(rawValue: entryMood)!
        } else {
            mood = .neutral
        }
        guard case segmentedControl.selectedSegmentIndex = EntryMood.moods.index(of: mood) else { return }
        textView.text = entry?.bodyText
    }
    
}
