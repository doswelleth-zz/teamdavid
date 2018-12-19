//
//  CoreDataStack.swift
//  JournalWeekend
//
//  Created by Lambda-School-Loaner-11 on 12/19/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    // MARK: - Single instance for app
    
    static let shared = CoreDataStack()
    
    // MARK: - Synchronous background save block
    
    func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) throws {
        
        var error: Error?
        
        context.performAndWait {
            do {
                try context.save()
            } catch let saveError {
                error = saveError
            }
        }
        if let error = error { throw error }
    }
    
    lazy var container: NSPersistentContainer = {
        
        // MARK: Load persistent stores
        let container = NSPersistentContainer(name: "Entry")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Error: \(error)")
            }
        }
        return container
    }()
    
    // MARK: - Single context instance for container
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
}
