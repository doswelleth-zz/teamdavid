//
//  EntryRepresentation.swift
//  JournalWeekend
//
//  Created by Lambda-School-Loaner-11 on 12/19/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

struct EntryRepresentation: Codable, Equatable {
    
    var title: String
    var bodyText: String?
    var mood: String
    var identifier: String
    var timestamp: String
}
