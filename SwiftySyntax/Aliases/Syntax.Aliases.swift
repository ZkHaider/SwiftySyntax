//
//  Syntax.Aliases.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 10/19/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit


#elseif os(OSX)
import AppKit

internal typealias UITextView = NSTextView
internal typealias UIFont = NSFont
internal typealias UIColor = UIColor
internal typealias UITextViewDelegate = NSTextViewDelegate
#endif 
