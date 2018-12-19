//
//  Entry+Encodable.swift
//  JournalWeekend
//
//  Created by Lambda-School-Loaner-11 on 12/19/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

extension Entry: Encodable {
    
    enum CodingKeys: CodingKey {
        case title
        case bodyText
        case timestamp
        case identifier
        case mood
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(title, forKey: CodingKeys.title)
        try container.encode(bodyText, forKey: CodingKeys.bodyText)
        try container.encode(timestamp, forKey: CodingKeys.timestamp)
        try container.encode(identifier, forKey: CodingKeys.identifier)
        try container.encode(mood, forKey: CodingKeys.mood)
    }
}
