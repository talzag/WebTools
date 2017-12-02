//
//  TextEditorWindowController.swift
//  WebTools
//
//  Created by Daniel Strokis on 11/26/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

import Cocoa

/// Provides an interface between an `NSDocument` and the various objects managed by this controller that facilitate editing source code.
class TextEditorWindowController: NSWindowController {
    
    /// A type-aware convenience wrapper around `self.contentViewController`.
    var textEditorViewController: TextEditorViewController? {
        return contentViewController as? TextEditorViewController
    }
    
    /// The content of this controller's `document`.
    var sourceCodeText: String {
        get {
            return textEditorViewController?.sourceCodeText ?? ""
        }
        
        set {
            textEditorViewController?.sourceCodeText = newValue
        }
    }
        
    /// Calls through to `NSTextView.breakUndoCoalescing()`. Used when `self.document` is saving.
    func breakUndoCoalescing() {
        textEditorViewController?.textView.breakUndoCoalescing()
    }
}
