//
//  Syntax.Highlighter.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 10/19/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

final class SyntaxHighlighter: NSObject {
    
    // MARK: - Views
    
    internal let textView: SyntaxTextView
    
    // MARK: - Attributes
    
    private var subscription: NSObjectProtocol? = nil
    
    // MARK: - Init
    
    init(textView: SyntaxTextView,
         notificationCenter: NotificationCenter = .default) {
        self.textView = textView
        super.init()
        #if os(OSX)
        self.subscription = notificationCenter.addObserver(
            forName: NSText.didChangeNotification,
            object: self.textView,
            queue: nil) { [unowned self] notification in
                self.handleTextChange(notification)
            }
        #elseif os(iOS)
        self.subscription = notificationCenter.addObserver(
            forName: UITextView.textDidChangeNotification,
            object: self.textView,
            queue: nil) { [unowned self] notification in
                self.handleTextChange(notification)
        }
        #endif
    }
    
    // MARK: - Notification
    
    private func handleTextChange(_ notification: Notification) {
        self.textView.processSyntaxHighlighting()
    }
    
    // MARK: - Deinit
    
    deinit {
        self.subscription = nil
    }
    
}
