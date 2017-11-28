//
//  WebCodeDocument.swift
//  WebTools
//
//  Created by Daniel Strokis on 11/26/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

import Cocoa

final class WebCodeDocument: NSDocument {
    
    var sourceCodeText: String?
    
    var editorWindowController: TextEditorWindowController?
    
    override class func canConcurrentlyReadDocuments(ofType typeName: String) -> Bool {
        return UTTypeConformsTo(typeName as CFString, "public.text" as CFString)
    }
    
    override func makeWindowControllers() {
        let storyboard = NSStoryboard(name: NSStoryboard.Name(string: "Main") as String, bundle: nil)
        let sceneIdentifier = NSStoryboard.SceneIdentifier(string: "TextEditorWindowController") as String
        guard let windowController = storyboard.instantiateController(withIdentifier: sceneIdentifier) as? TextEditorWindowController else {
            return
        }
        
        editorWindowController = windowController
        editorWindowController?.sourceCodeText = sourceCodeText
        
        self.addWindowController(windowController)
    }

    override func data(ofType typeName: String) throws -> Data {
        editorWindowController?.breakUndoCoalescing()
        sourceCodeText = editorWindowController?.sourceCodeText
        return sourceCodeText?.data(using: .utf8) ?? Data()
    }
    
    override func read(from data: Data, ofType typeName: String) throws {
        guard let text = String(data: data, encoding: .utf8) else {
            throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        }
        
        sourceCodeText = text
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }
}
