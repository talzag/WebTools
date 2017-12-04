//
//  WebCodeDocumentTests.swift
//  WebToolsTests
//
//  Created by Daniel Strokis on 12/3/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

import XCTest
@testable import WebTools

class WebCodeDocumentTests: XCTestCase {
    
    var document: WebCodeDocument?
    
    override func setUp() {
        super.setUp()
        
        document = WebCodeDocument()
    }
    
    override func tearDown() {
        document = nil
        
        super.tearDown()
    }
    
    // MARK: - Class properties
    
    func testClassAutosavesInPlace() {
        XCTAssertTrue(WebCodeDocument.autosavesInPlace)
    }
    
    func testClassCanConcurrentlyReadTextDocuments() {
        XCTAssertTrue(WebCodeDocument.canConcurrentlyReadDocuments(ofType: kUTTypeText as String))
        XCTAssertTrue(WebCodeDocument.canConcurrentlyReadDocuments(ofType: kUTTypeHTML as String))
        XCTAssertTrue(WebCodeDocument.canConcurrentlyReadDocuments(ofType: kUTTypeJavaScript as String))
        XCTAssertTrue(WebCodeDocument.canConcurrentlyReadDocuments(ofType: kUTTypeJSON as String))
        XCTAssertTrue(WebCodeDocument.canConcurrentlyReadDocuments(ofType: kUTTypeUTF8PlainText as String))
    }
    
    // MARK: - Instance methods
    
    func testMakeWindowControllers() {
        XCTAssertNil(document?.editorWindowController)
        
        document?.makeWindowControllers()
        
        XCTAssertNotNil(document?.editorWindowController)
    }
    
    func testWriteData() {
        let text = "Some plain text"
        
        document?.sourceCodeText = text as NSString
        
        let data = try! document?.data(ofType: kUTTypeText as String)
        XCTAssertEqual(data, text.data(using: .utf8))
    }
    
    func testReadUTF8Data() {
        let text = "Some plain text"
        guard let data = text.data(using: .utf8) else {
            XCTFail("String encoding failed")
            return
        }
        
        XCTAssertNoThrow(try document?.read(from: data, ofType: kUTTypeText as String))
        XCTAssertEqual(text, document!.sourceCodeText as String)
    }
    
    func testReadingNonUTF16Data() {
        let text = "Some plain text"
        guard let data = text.data(using: .utf16) else {
            XCTFail("String encoding failed")
            return
        }
        
        XCTAssertNoThrow(try document?.read(from: data, ofType: kUTTypeText as String))
    }
    
    func testFailReadingNonTextData() {
        let text = "Some plain text"
        guard let data = text.data(using: .utf8) else {
            XCTFail("String encoding failed")
            return
        }
        
        XCTAssertThrowsError(try document?.read(from: data, ofType: kUTTypePNG as String))
    }
}
