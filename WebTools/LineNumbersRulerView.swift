//
//  LineNumbersRulerView.swift
//  WebTools
//
//  Created by Daniel Strokis on 12/1/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

import Cocoa

class LineNumbersRulerView: NSRulerView {
    
    override func draw(_ dirtyRect: NSRect) {
        guard let context = NSGraphicsContext.current else {
            return
        }
        
        context.saveGraphicsState()
        
        NSColor.white.set()
        let rectPath = NSBezierPath(rect: bounds)
        rectPath.fill()
        
        context.restoreGraphicsState()
        
        drawHashMarksAndLabels(in: bounds)
    }
    
    func drawLineNumber(_ number: Int, forGlyphAtIndex glyphIndex: Int, with attributes: [NSAttributedStringKey: Any]) -> Int {
        guard let textView = clientView as? NSTextView,
              let layoutManager = textView.layoutManager,
              let textContainer = textView.textContainer else {
                return NSNotFound
        }
        
        let lineRange = (textView.string as NSString).lineRange(for: NSRange(location: glyphIndex, length: 0))
        let lineRect = layoutManager.boundingRect(forGlyphRange: lineRange, in: textContainer)
        let lineNum = NSAttributedString(string: "\(number)", attributes: attributes)
        let lineNumSize = lineNum.size()
        let fragmentRect = layoutManager.lineFragmentRect(forGlyphAt: glyphIndex, effectiveRange: nil)
        
        let lineNumRect = NSRect(x: (ruleThickness - lineNumSize.width) / 2.0,
                                 y: fragmentRect.origin.y - 1.0,
                                 width: lineNumSize.width,
                                 height: lineRect.size.height)
        
        lineNum.draw(in: lineNumRect)
        
        return NSMaxRange(lineRange)
    }
    
    override func drawHashMarksAndLabels(in rect: NSRect) {
        guard let textView = clientView as? NSTextView,
              let layoutManager = textView.layoutManager,
              let textContainer = textView.textContainer else {
            return
        }
        
        var lineCount = 1
        
        let glyphRange = layoutManager.glyphRange(for: textContainer)
        var glyphIndex = 0
        
        while glyphIndex < NSMaxRange(glyphRange) {
            glyphIndex = drawLineNumber(lineCount, forGlyphAtIndex: glyphIndex, with: [
                .font: NSFont(descriptor: textView.font!.fontDescriptor, size: textView.font!.pointSize - 1.0)!,
                .foregroundColor: NSColor.gray
            ])
            lineCount += 1
        }
        
        if layoutManager.extraLineFragmentRect != .zero {
            let extraRect = layoutManager.extraLineFragmentRect
            let lineNum = NSAttributedString(string: "\(lineCount)", attributes: [
                .font: NSFont(descriptor: textView.font!.fontDescriptor, size: textView.font!.pointSize - 1.0)!,
                .foregroundColor: NSColor.lightGray
            ])
            let lineNumSize = lineNum.size()
            let lineNumRect = NSRect(x: (ruleThickness - lineNumSize.width) / 2.0,
                                     y: extraRect.origin.y - 1.0,
                                     width: lineNumSize.width,
                                     height: extraRect.size.height)
            
            lineNum.draw(in: lineNumRect)
        }
    }
}
