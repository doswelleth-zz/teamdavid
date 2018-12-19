//
//  EntryController.swift
//  JournalWeekend
//
//  Created by Lambda-School-Loaner-11 on 12/19/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation
import CoreData

let baseURL = URL(string: "https://journalweekend-69c76.firebaseio.com/")!

class EntryController {
    
    // MARK: - Singleton
    
    let moc = CoreDataStack.shared.mainContext
    
    // MARK: - Handler
    
    typealias CompletionHandler = (Error?) -> Void
    
    init() {
        let backgroundContext = CoreDataStack.shared.container.newBackgroundContext()
        fetchEntriesFromServer(context: backgroundContext)
    }
    
    
    // MARK: - Server fetch entries logic
    
    func fetchEntriesFromServer(completion: @escaping CompletionHandler = {_ in}, context: NSManagedObjectContext) {
        
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
            }
            
            guard let data = data else {
                NSLog("No data")
                completion(NSError())
                return
            }
            
            context.performAndWait {
                do {
                    let entryRepresentations = Array(try JSONDecoder().decode([String: EntryRepresentation].self, from: data).values)
                    
                    let backgroundMoc = CoreDataStack.shared.container.newBackgroundContext()
                    
                    // Save the context only after the update/creation process is complete
                    try self.updateEntries(with: entryRepresentations, context: backgroundMoc)
                    
                    // Remember that save() itself must be called on the context's private queue using perform() or performAndWait()
                    try CoreDataStack.shared.save()
                    completion(nil)
                    
                } catch {
                    NSLog("Error: \(error)")
                    completion(error)
                    return
                }
            }
            }.resume()
    }
    
    /*
     Extract the code responsible for iterating through the array of fetched EntryRepresentations and updating or creating corresponding Tasks. Put it in a function that takes a context.
     */
    
    // MARK: - Server update entries logic
    
    func updateEntries(with representations: [EntryRepresentation], context: NSManagedObjectContext) throws {
        
        var error : Error?
        
        context.performAndWait {
            
            for entryRep in representations {
                guard let uuid = UUID(uuidString: entryRep.identifier) else { continue }
                
                let entry = self.fetchEntry(forUUID: uuid, context: context)
                
                if let entry = entry {
                    self.update(entry: entry, with: entryRep)
                } else {
                    let _ = Entry(entryRepresentation: entryRep, context: context)
                }
            }
            
            do {
                try context.save()
            } catch let saveError {
                error = saveError
            }
        }
        if let error = error { throw error }
    }
    
    // MARK: - Server `PUT` entries logic
    
    func put(entry: Entry, completion: @escaping CompletionHandler = {_ in}) {
        
        let uuid = entry.identifier ?? ""
        let requestURL = baseURL.appendingPathComponent(uuid).appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        do {
            guard var representation = entry.entryRepresentation else {
                completion(NSError())
                return
            }
            representation.identifier = uuid
            entry.identifier = uuid
            try CoreDataStack.shared.save()
            request.httpBody = try JSONEncoder().encode(representation)
        } catch {
            NSLog("Error: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
                completion(error)
                return
            }
            completion(nil)
            }.resume()
    }
    
    // MARK: - CRUD logic
    
    func create(entry: Entry, title: String, bodyText: String, timestamp: Date, identifier: String) {
        
        entry.title = title
        entry.bodyText = bodyText
        entry.identifier = identifier
        entry.timestamp = timestamp
        
        put(entry: entry)
    }
    
    func update(entry: Entry, with representation: EntryRepresentation) {
        entry.title = representation.title
        entry.bodyText = representation.bodyText
        entry.mood = representation.mood
        
        put(entry: entry)
    }
    
    func delete(entry: Entry) {
        moc.delete(entry)
        deleteEntryFromServer(entry: entry)
    }
    
    // MARK: - Server delete entries logic
    
    func deleteEntryFromServer(entry: Entry, completion: @escaping CompletionHandler = {_ in}) {
        
        guard let identifier = entry.identifier else { return }
        
        let url = baseURL.appendingPathComponent(identifier)
            .appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    /*
     Make your fetchSingleEntry method accept a context argument that it uses to fetch from.
     */
    
    // MARK: Fetch single entry
    
    private func fetchEntry(forUUID uuid: UUID, context: NSManagedObjectContext) -> Entry? {
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "identifier == %@", uuid as NSUUID)
        
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            NSLog("Error: \(error)")
            return nil
        }
    }
}
