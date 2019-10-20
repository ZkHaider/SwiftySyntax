//
//  Syntax.Text.Storage.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 10/19/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

public final class SyntaxTextStorage: NSTextStorage {
    
    // MARK: - Attributes
    
    private var storage = NSTextStorage()
    
    // MARK: - String

    public override var string: String {
        return storage.string
    }
    
    public override func attributes(at location: Int,
                                    effectiveRange range: NSRangePointer?) -> [NSAttributedString.Key : Any] {
        return storage.attributes(at: location,
                                  effectiveRange: range)
    }
    
    // MARK: - Editing
    
    public override func replaceCharacters(in range: NSRange, with str: String) {
        beginEditing()
        storage.beginEditing()
        storage.replaceCharacters(in: range, with: str)
        storage.edited(
            .editedCharacters,
            range: range,
            changeInLength: (str as NSString).length - range.length
        )
        edited(
            .editedCharacters,
            range: range,
            changeInLength: (str as NSString).length - range.length
        )
        endEditing()
    }
    
    public override func setAttributes(_ attrs: [NSAttributedString.Key : Any]?,
                                       range: NSRange) {
        beginEditing()
        storage.beginEditing()
        storage.setAttributes(attrs, range: range)
        storage.edited(
            .editedAttributes,
            range: range,
            changeInLength: 0
        )
        edited(
            .editedAttributes,
            range: range,
            changeInLength: 0
        )
        storage.endEditing()
        endEditing()
    }
        
}
