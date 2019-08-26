//
//  Syntax.Tree.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 8/25/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

final class SyntaxTree {
    
    // MARK: - Pointer
    
    let tree: OpaquePointer
    
    // MARK: - Init
    
    init(pointer: OpaquePointer) {
        self.tree = pointer
    }
    
    // MARK: - Deinit
    
    deinit {
        ts_tree_delete(self.tree)
    }
    
}
