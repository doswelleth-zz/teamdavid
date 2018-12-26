//
//  MessagePage.swift
//  Message BoardUITests
//
//  Created by David Doswell on 9/14/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import XCTest

struct MessagePage: TestPage {
    
    let testCase: XCTestCase
    
    // MARK: - MessageThreadsTableViewController
    
    private func threadTitleTextField() -> XCUIElement {
        return app.textFields["MessageThreadsTableViewController.ThreadTextField"]
    }
    
    private func messageThreadCell() -> XCUIElement {
        return app.cells["MessageThreadsTableViewController.MessageThreadCell"]
    }
    
    // MARK: - MessageThreadDetailTableViewController
    
    private func messageThreadDetailCell() -> XCUIElement {
        return app.cells["MessageThreadDetailTableViewController.MessageThreadCell"]
    }
    
    var barButton: XCUIElement {
        return app.buttons["MessageThreadDetailTableViewController.BarButton"]
    }
    
    // MARK: - MessageDetailViewController
    
    var barButtonDetail: XCUIElement {
        return app.buttons["MessageDetailViewController.BarButton"]
    }
    
    private func detailViewTextField() -> XCUIElement {
        return app.textFields["MessageDeatilViewController.TextField"]
    }
    
    private func detailViewTextView() -> XCUIElement {
        return app.textFields["MessageDeatilViewController.TextView"]
    }
    
    
    // MARK: - Actions
    
        // MessageThreadsTableVC
   
    @discardableResult func textFieldEngaged(file: String = #file, line: UInt = #line) -> MessagePage {
        testCase.expect(exists: textField(), file: file, line: line)
        return self
    }
    
    @discardableResult func cellTapped(file: String = #file, line: UInt = #line) -> MessagePage {
        testCase.expect(exists: messageThreadCell(), file: file, line: line)
        return self
    }

        // MessageThreadsDetail
   
    @discardableResult func detailCellTapped(file: String = #file, line: UInt = #line) -> MessagePage {
        
        testCase.expect(exists: messageThreadDetailCell(), file: file, line: line)
        return self
    }
    
        // MessageDetailVC
    
    @discardableResult func detailViewTextFieldTap(file: String = #file, line: UInt = #line) -> MessagePage {
        testCase.expect(exists: detailViewTextField(), file: file, line: line)
        return self
    }

    @discardableResult func detailViewTextViewTap(file: String = #file, line: UInt = #line) -> MessagePage {
        testCase.expect(exists: detailViewTextView(), file: file, line: line)
        return self
    }
    
    


    
    
    // Verifications
    
    
    
    
}
