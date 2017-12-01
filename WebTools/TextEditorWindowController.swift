//
//  TextEditorWindowController.swift
//  WebTools
//
//  Created by Daniel Strokis on 11/26/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

import Cocoa

class TextEditorWindowController: NSWindowController {
    
    var textEditorViewController: TextEditorViewController? {
        return contentViewController as? TextEditorViewController
    }
    
    var sourceCodeText: String {
        get {
            return textEditorViewController?.sourceCodeText ?? ""
        }
        
        set {
            textEditorViewController?.sourceCodeText = newValue
        }
    }
        
    func breakUndoCoalescing() {
        textEditorViewController?.textView.breakUndoCoalescing()
    }
}
