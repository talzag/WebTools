//
//  WebToolsUITests.swift
//  WebToolsUITests
//
//  Created by Daniel Strokis on 12/1/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

import XCTest

class WebToolsUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    
}
