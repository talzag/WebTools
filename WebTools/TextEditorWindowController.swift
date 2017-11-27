//
//  TextEditorWindowController.swift
//  WebTools
//
//  Created by Daniel Strokis on 11/26/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

import Cocoa

class TextEditorWindowController: NSWindowController {
    
    var textViewController: TextEditorViewController? {
        return contentViewController as? TextEditorViewController
    }
    
    var sourceCodeText: String? {
        get {
            return textViewController?.sourceCodeText
        }
        
        set {
            textViewController?.sourceCodeText = newValue
        }
    }
    
    func breakUndoCoalescing() {
        textViewController?.textView.breakUndoCoalescing()
    }
}
