//
//  Message_BoardUITests.swift
//  Message BoardUITests
//
//  Created by Spencer Curtis on 9/14/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import XCTest

class Message_BoardUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()

        // KEEP THIS SETUP FUNCTION EXACTLY AS IS.
        
        continueAfterFailure = false
        
        let app = XCUIApplication()
        
        app.launchArguments = ["UITesting"]
        app.launch()
    }
    
    func testExample() {
        let app = XCUIApplication()
        print(app)
    }
    
    func testTextField() {
        MessagePage(testCase: self)
        .textFieldEngaged()
    }
    
    func testMessageCell() {
        MessagePage(testCase: self)
        .cellTapped()
    }
    
    func testMessageDetailCell() {
        MessagePage(testCase: self)
        .detailCellTapped()
    }
    
    func testDetailViewTextField() {
        MessagePage(testCase: self)
        .detailViewTextFieldTap()
    }
    
    func testDetailViewTextView() {
        MessagePage(testCase: self)
        .detailViewTextViewTap()
    }
    
    
}
