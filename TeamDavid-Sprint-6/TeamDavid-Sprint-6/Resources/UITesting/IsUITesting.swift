//
//  IsUITesting.swift
//  TeamDavid-Sprint-6
//
//  Created by David Doswell on 12/24/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

var isUITesting: Bool {
    return CommandLine.arguments.contains("UITesting")
}
