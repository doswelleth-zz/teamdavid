//
//  Note.swift
//  TeamDavid-Sprint-7
//
//  Created by David Doswell on 12/26/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

struct Note: Codable, Equatable {
    var title: String
    var description: String
    var date: Date
}
