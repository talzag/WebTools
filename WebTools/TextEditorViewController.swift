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
    
    dynamic let defaultFont = NSFont(name: "Menlo", size: 11.0)
    
    dynamic var sourceCodeText: String?
    
    dynamic var attrSourceCodeText: String?
}
