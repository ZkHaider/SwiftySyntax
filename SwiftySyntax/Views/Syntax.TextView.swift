//
//  Syntax.TextView.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 10/19/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

public final class SyntaxTextView: UITextView {
    
    // MARK: - Attributes
    
    private var _syntaxTextStorage: SyntaxTextStorage
    public var syntaxTextStorage: SyntaxTextStorage {
        return _syntaxTextStorage
    }
    
//    internal let syntaxTextStorage: NSTextStorage
    
    public var syntaxTextContainer: SyntaxTextContainer {
        return self.textContainer as! SyntaxTextContainer
    }
    
    public var syntaxLayoutManager: SyntaxTextLayoutManager {
        return self.layoutManager as! SyntaxTextLayoutManager
    }
    
    // MARK: - Parser
    
    internal let syntaxParser: SyntaxParser
    
    // MARK: - Init
    
    public required init(frame: CGRect,
                         language: SyntaxLanguage) {
        
        // Declare syntax stuff
        self._syntaxTextStorage = SyntaxTextStorage()
        let syntaxTextLayoutManager = SyntaxTextLayoutManager()
        let syntaxTextContainer = SyntaxTextContainer(
            size: CGSize(
                width: CGFloat.greatestFiniteMagnitude,
                height: CGFloat.greatestFiniteMagnitude
            )
        )
        syntaxTextContainer.widthTracksTextView = true
        let exclusionPath = UIBezierPath(rect:
            CGRect(
                x: 0,
                y: 0,
                width: 30.0,
                height: CGFloat.greatestFiniteMagnitude
            )
        )
        
        syntaxTextContainer.exclusionPaths = [exclusionPath]
        syntaxTextLayoutManager.addTextContainer(syntaxTextContainer)
        self._syntaxTextStorage.addLayoutManager(syntaxTextLayoutManager)
        
        // Initialize our parser
        self.syntaxParser = SyntaxParser(config: DefaultSyntaxConfig(language: language))
        
        super.init(frame: frame,
                   textContainer: syntaxTextContainer)
        
        // Delegate
        self.syntaxTextStorage.delegate = self
        self.delegate = self 
        
        isOpaque = false
        backgroundColor = UIColor.clear
        autocorrectionType = .no
        autocapitalizationType = .none
        spellCheckingType = .no
        keyboardType = .asciiCapable
        keyboardAppearance = .dark
        indicatorStyle = .white
        bounces = true
        alwaysBounceVertical = true
        keyboardDismissMode = .interactive
        dataDetectorTypes = []
        returnKeyType = .default
        enablesReturnKeyAutomatically = false
        self.textColor = .white
    }
    
    @available(*, unavailable)
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        fatalError("init(frame:textContainer:) not implemented")
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Processing
    
    internal func processSyntaxHighlighting() {
        self.syntaxTextStorage.beginEditing()
        
        // Go ahead and handle parsing and such
        
        self.syntaxTextStorage.endEditing()
    }
    
}

extension SyntaxTextView: UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {
        
    }
    
}

extension SyntaxTextView: NSTextStorageDelegate {
    
    public func textStorage(_ textStorage: NSTextStorage,
                            willProcessEditing editedMask: NSTextStorage.EditActions,
                            range editedRange: NSRange,
                            changeInLength delta: Int) {
        
    }
    
    public func textStorage(_ textStorage: NSTextStorage,
                            didProcessEditing editedMask: NSTextStorage.EditActions,
                            range editedRange: NSRange,
                            changeInLength delta: Int) {
        
    }
    
}
