//
//  WebToolsTests.swift
//  WebToolsTests
//
//  Created by Daniel Strokis on 11/24/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

import XCTest
@testable import WebTools

class WebToolsTests: XCTestCase {
    func testApplicationShouldTerminateAfterLastWindowClosed() {
        let delegate = AppDelegate()
        
        XCTAssertFalse(delegate.applicationShouldTerminateAfterLastWindowClosed(NSApp))
    }
}
