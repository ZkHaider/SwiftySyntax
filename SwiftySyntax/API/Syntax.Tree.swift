//
//  Syntax.Tree.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 8/25/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

public final class SyntaxTree {
    
    // MARK: - Pointer
    
    public let tree: OpaquePointer
    
    // MARK: - Attributes
    
    public var rootNode: SyntaxNode {
        return SyntaxNode(node: ts_tree_root_node(self.tree))
    }
    
    // MARK: - Init
    
    internal init(pointer: OpaquePointer) {
        self.tree = pointer
    }
    
    // MARK: - Class Functions
    
    public func delete() {
        ts_tree_delete(self.tree)
    }
    
    public func copy() -> SyntaxTree {
        return SyntaxTree(
            pointer: ts_tree_copy(self.tree)
        )
    }
    
}
