//
//  Entry+Convenience.swift
//  JournalWeekend
//
//  Created by Lambda-School-Loaner-11 on 12/19/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation
import CoreData

enum EntryMood: String {
    case smiling = "🙂"
    case neutral = "😐"
    case frowning = "☹️"
    
    static var moods = [EntryMood.smiling, EntryMood.neutral, EntryMood.frowning]
}

extension Entry {
    
    // MARK: - Set the value of attributes you defined in the data model using the parameters of the initializer.
    
    convenience init(title: String, bodyText: String, identifier: String = UUID().uuidString, timestamp: Date = Date(), mood: EntryMood, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        self.title = title
        self.bodyText = bodyText
        self.identifier = identifier
        self.timestamp = timestamp
        self.mood = mood.rawValue
    }
    
    /*
     Change your convenience initalizer for creating an Entry from an EntryRepresentation to accept a context in which to create the new Entry
     */
    
    convenience init?(entryRepresentation: EntryRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        guard let mood = EntryMood(rawValue: entryRepresentation.mood), let identifier = UUID(uuidString: entryRepresentation.identifier) else { return nil }
        
        self.init(title: entryRepresentation.title,
                  bodyText: entryRepresentation.bodyText!, identifier: identifier.uuidString, mood: mood, context: context)
    }
    
    var entryRepresentation: EntryRepresentation? {
        guard let title = title, let mood = mood, let timestamp = timestamp else { return nil }
        
        return EntryRepresentation(title: title, bodyText: bodyText, mood: mood, identifier: identifier ?? "", timestamp: timestamp.description)
    }
}
