//
//  WebCodeDocument.swift
//  WebTools
//
//  Created by Daniel Strokis on 11/26/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

import Cocoa

/// A document containing web language source code (HTML, CSS, JS, etc.).
final class WebCodeDocument: NSDocument {
    
    /// The raw text content of the file this document represents. This is of type `NSString` to take advantage of reference semantics.
    var sourceCodeText: NSString = ""
    
    /// The main window controller managed by `self`.
    var editorWindowController: TextEditorWindowController?
    
    override class var autosavesInPlace: Bool {
        return true
    }
    
    override class func canConcurrentlyReadDocuments(ofType typeName: String) -> Bool {
        return UTTypeConformsTo(typeName as CFString, kUTTypeText)
    }
    
    override func makeWindowControllers() {
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        let sceneIdentifier = NSStoryboard.SceneIdentifier(rawValue: "TextEditorWindowController")
        
        guard let windowController = storyboard.instantiateController(withIdentifier: sceneIdentifier) as? TextEditorWindowController else {
            return
        }
        
        editorWindowController = windowController
        editorWindowController?.sourceCodeText = sourceCodeText
        
        self.addWindowController(windowController)
    }

    override func data(ofType typeName: String) throws -> Data {
        editorWindowController?.breakUndoCoalescing()
        
        return (sourceCodeText as String).data(using: .utf8) ?? Data()
    }
    
    override func read(from data: Data, ofType typeName: String) throws {
        guard UTTypeConformsTo(typeName as CFString, kUTTypeText) else {
            throw NSError(domain: NSOSStatusErrorDomain, code: readErr, userInfo: nil)
        }
        
        if let text = String(data: data, encoding: .utf8) {
            sourceCodeText = text as NSString
        } else if let text = String(data: data, encoding: .utf16) {
            sourceCodeText = text as NSString
        } else {
            throw NSError(domain: NSOSStatusErrorDomain, code: readErr, userInfo: nil)
        }
    }
}
