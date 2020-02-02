//
//  Syntax.Text.LayoutManager.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 10/19/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

public final class SyntaxTextLayoutManager: NSLayoutManager {
    
    // MARK: - Attributes
    
    internal let syntaxBackgroundFont: UIFont = UIFont(name: "Menlo", size: 10.0)!
    internal let syntaxBackgroundColor: UIColor = .lightGray
    
    internal lazy var attributes: [NSAttributedString.Key: Any] = {
        let attributes: [NSAttributedString.Key: Any] = [
            .font : self.syntaxBackgroundFont,
            .foregroundColor : self.syntaxBackgroundColor
        ]
        return attributes
    }()
    
    fileprivate var lastParagraphNumber: Int = 0
    fileprivate var lastParagraphLocation: Int = 0
    internal let lineNumberWidth: CGFloat = 30.0
    
    // MARK: - LayoutManager 
    
    override public func drawBackground(forGlyphRange glyphsToShow: NSRange, at origin: CGPoint)
    {
        super.drawBackground(forGlyphRange: glyphsToShow, at: origin)
                
        var numberRect = CGRect.zero
        var paragraphNumber = 0
        
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setFillColor(UIColor.white.withAlphaComponent(0.1).cgColor)
        ctx?.fill(CGRect(x: 0, y: 0, width: lineNumberWidth, height: self.textContainers[0].size.height))
        
        self.enumerateLineFragments(forGlyphRange: glyphsToShow)
        { (rect, usedRect, textContainer, glyphRange, stop) in
            let charRange = self.characterRange(forGlyphRange: glyphRange, actualGlyphRange: nil)
            let paragraphRange = (self.textStorage!.string as NSString).paragraphRange(for: charRange)
            
            if charRange.location == paragraphRange.location
            {
                numberRect = CGRect(x: 0, y: rect.origin.y, width: self.lineNumberWidth, height: rect.size.height).offsetBy(dx: origin.x, dy: origin.y)
                paragraphNumber = self.paragraphNumber(forRange: charRange)
                let lineNumber = "\(paragraphNumber + 1)" as NSString
                let size = lineNumber.size(withAttributes: self.attributes)
                lineNumber.draw(in: numberRect.offsetBy(dx: numberRect.width - 4 - size.width, dy: (numberRect.height - size.height) * 0.5 + 1.0), withAttributes: self.attributes)
            }
        }
        
        if NSMaxRange(glyphsToShow) > self.numberOfGlyphs
        {
            let lineNumber = "\(paragraphNumber + 2)" as NSString
            let size = lineNumber.size(withAttributes: attributes)
            numberRect = numberRect.offsetBy(dx: 0, dy: numberRect.height)
            lineNumber.draw(in: numberRect.offsetBy(dx: numberRect.width - 4 - size.width, dy: (numberRect.height - size.height) * 0.5 + 1.0), withAttributes: attributes)
        }
    }
    
    fileprivate func paragraphNumber(forRange charRange: NSRange) -> Int
    {
        if charRange.location == lastParagraphLocation
        {
            return lastParagraphNumber
        }
        else if charRange.location < lastParagraphLocation
        {
            let string = textStorage!.string as NSString
            
            var paragraphNumber = lastParagraphNumber
            
            string.enumerateSubstrings(
                in: NSRange(
                    location: charRange.location,
                    length: lastParagraphLocation - charRange.location),
                options: [.byParagraphs, .substringNotRequired, .reverse])
            { (substring, substringRange, enclosingRange, stop) in
                if enclosingRange.location <= charRange.location
                {
                    stop.pointee = true
                }
                paragraphNumber -= 1
            }
            lastParagraphNumber = paragraphNumber
            lastParagraphLocation = charRange.location
            return paragraphNumber
        }
        else
        {
            let string = textStorage!.string as NSString
            
            var paragraphNumber = lastParagraphNumber
            
            string.enumerateSubstrings(
                in: NSRange(
                    location: lastParagraphLocation,
                    length: charRange.location - lastParagraphLocation),
                options: [.byParagraphs, .substringNotRequired])
            { (substring, substringRange, enclosingRange, stop) in
                if enclosingRange.location >= charRange.location
                {
                    stop.pointee = true
                }
                paragraphNumber += 1
            }
            lastParagraphNumber = paragraphNumber
            lastParagraphLocation = charRange.location
            return paragraphNumber
        }
    }
}
