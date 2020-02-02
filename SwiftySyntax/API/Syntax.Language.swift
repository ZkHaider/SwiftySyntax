//
//  Tree.Language.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 8/25/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

public enum SyntaxLanguage {
    case json
    case swift
//    case python
//    case php
//    case rust
    
    internal var tsLanguage: UnsafePointer<TSLanguage>? {
        switch self {
        case .json:
            return tree_sitter_json()
        case .swift:
            return tree_sitter_swift()
        }
        
    }
}
