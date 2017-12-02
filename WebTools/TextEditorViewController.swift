//
//  TextEditorViewController.swift
//  WebTools
//
//  Created by Daniel Strokis on 11/24/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

import Cocoa

/// A view controller that manages an `NSTextView` and facilitates editing source code.
final class TextEditorViewController: NSViewController, NSTextViewDelegate {
    
    /// The text view managed by this view controller.
    @IBOutlet var textView: NSTextView!
    
    // MARK: - Properties
    
    /// The default `NSFont` applied to all text in `textView`.
    let defaultFont = NSFont(name: "Menlo", size: 11.0)
    
    var sourceCodeText: String = "" {
        didSet {
            textView.string = sourceCodeText
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NSScrollView.rulerViewClass = LineNumbersRulerView.self
    }
    
    override func viewDidLoad() {
        textView.string = sourceCodeText
        textView.font = defaultFont
        
        guard let scrollView = textView.enclosingScrollView else {
            return
        }
        scrollView.hasVerticalRuler = true
        scrollView.rulersVisible = true
        
        guard let rulerView = scrollView.verticalRulerView else {
            return
        }
        
        rulerView.clientView = textView
        rulerView.ruleThickness = 26.0
        
        textView.postsFrameChangedNotifications = true
        NotificationCenter.default.addObserver(forName: NSView.frameDidChangeNotification, object: textView, queue: nil) { (notification) in
            rulerView.needsDisplay = true
        }
    }
    
    // MARK: - NSTextViewDelegate
    
    func textDidChange(_ notification: Notification) {
        textView.enclosingScrollView?.verticalRulerView?.needsDisplay = true
    }
    
    func textView(_ view: NSTextView, menu: NSMenu, for event: NSEvent, at charIndex: Int) -> NSMenu? {
        // TODO: Create a context menu with commands specific to the kind of source code being edited.
        return menu
    }
}
