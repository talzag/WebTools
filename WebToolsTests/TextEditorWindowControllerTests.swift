//
//  TextEditorWindowControllerTests.swift
//  WebToolsTests
//
//  Created by Daniel Strokis on 12/3/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

import XCTest
@testable import WebTools

class TextEditorWindowControllerTests: XCTestCase {

    var windowController: TextEditorWindowController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        let sceneIdentifier = NSStoryboard.SceneIdentifier(rawValue: "TextEditorWindowController")
        
        windowController = storyboard.instantiateController(withIdentifier: sceneIdentifier) as! TextEditorWindowController
    }
    
    override func tearDown() {
        windowController = nil
        
        super.tearDown()
    }
    
    func testTextEditorViewControllerGetter() {
        let contentViewController = windowController.contentViewController
        let textEditorViewController = windowController.textEditorViewController
        
        XCTAssertEqual(contentViewController, textEditorViewController)
    }
    
    func testSourceCodeText() {
        let textEditorViewController = windowController.textEditorViewController
        
        let text: NSString = "Some text"
        textEditorViewController?.sourceCodeText = text
        
        XCTAssertEqual(text, windowController.sourceCodeText)
        
        let newText: NSString = "Different text"
        windowController.sourceCodeText = newText
        
        XCTAssertEqual(newText, textEditorViewController?.sourceCodeText)
        
        windowController.contentViewController = nil
        XCTAssertEqual("", windowController.sourceCodeText)
    }
}
