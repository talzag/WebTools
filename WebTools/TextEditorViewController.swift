//
//  TextEditorViewController.swift
//  WebTools
//
//  Created by Daniel Strokis on 11/24/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

import Cocoa

final class TextEditorViewController: NSViewController, NSTextViewDelegate {
    
    @IBOutlet var textView: NSTextView!
    
    // MARK: - Bindings
    
    dynamic let defaultFont = NSFont(name: "Menlo", size: 11.0)
    dynamic var sourceCodeText: String?
    
    // MARK: - NSTextViewDelegate
    
    func textDidChange(_ notification: Notification) {
        
    }
    
    func textView(_ view: NSTextView, menu: NSMenu, for event: NSEvent, at charIndex: Int) -> NSMenu? {
        return menu
    }
}
