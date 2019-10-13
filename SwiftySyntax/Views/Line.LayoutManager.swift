//
//  Line.LayoutManager.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 8/28/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit

final class LineNumberLayoutManager: NSLayoutManager {
    
    // MARK: - Attributes
    
    fileprivate var lastParagraphNumber: Int = 0
    fileprivate var lastParagraphLocation: Int = 0
    internal let lineNumberWidth: CGFloat = 30.0
    
    // MARK: - LayoutManager Functions
    
    override func drawBackground(forGlyphRange glyphsToShow: NSRange,
                                 at origin: CGPoint) {
        super.drawBackground(forGlyphRange: glyphsToShow,
                             at: origin)
    }
    
    fileprivate func paragraphNumber(forRange charRange: NSRange) -> Int {
        
        guard
            charRange.location != lastParagraphLocation
            else { return lastParagraphNumber }
        
        if charRange.location < lastParagraphLocation {
            
            let string = textStorage!.string as NSString
            var paragraphNumber = lastParagraphNumber
            
            string.enumerateSubstrings(
                in: NSRange(
                    location: charRange.location,
                    length: lastParagraphLocation - charRange.location
                ),
                options: [.byParagraphs, .substringNotRequired, .reverse],
                using: { (substring, substringRange, enclosingRange, stop) in
                    if enclosingRange.location <= charRange.location {
                        stop.pointee = true
                    }
                    paragraphNumber -= 1
                }
            )
            lastParagraphNumber = paragraphNumber
            lastParagraphLocation = charRange.location
            return paragraphNumber
            
        } else {
        
            let string = textStorage!.string as NSString
            var paragraphNumber = lastParagraphNumber
            
            string.enumerateSubstrings(
                in: NSRange(
                    location: charRange.location,
                    length: lastParagraphLocation - charRange.location
                ),
                options: [.byParagraphs, .substringNotRequired, .reverse],
                using: { (substring, substringRange, enclosingRange, stop) in
                    if enclosingRange.location <= charRange.location {
                        stop.pointee = true
                    }
                    paragraphNumber -= 1
                }
            )
            lastParagraphNumber = paragraphNumber
            lastParagraphLocation = charRange.location
            return paragraphNumber
        }
    }
    
}

#endif
