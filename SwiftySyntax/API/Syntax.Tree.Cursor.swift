//
//  Syntax.Tree.Cursor.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 8/27/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

public final class SyntaxCursor {
    
    // MARK: - Pointer
    
    internal var cursor: TSTreeCursor
    
    // MARK: - Attributes
    
    public var currentFieldName: String? {
        guard
            let pointer = ts_tree_cursor_current_field_name(&cursor)
            else { return nil }
        return String(cString: pointer)
    }
    
    public var currentFieldId: Int {
        let fieldId = ts_tree_cursor_current_field_id(&cursor)
        return Int(fieldId)
    }
    
    // MARK: - Init
    
    public init(cursor: TSTreeCursor) {
        self.cursor = cursor
    }
    
    // MARK: - Class Functions
    
    public func delete() {
        ts_tree_cursor_delete(&self.cursor)
    }
    
    public func reset(at node: SyntaxNode) {
        ts_tree_cursor_reset(&self.cursor,
                             node.node)
    }
    
    public func currentNode() -> SyntaxNode {
        let node = ts_tree_cursor_current_node(&self.cursor)
        return SyntaxNode(node: node)
    }
    
    public func goToParent() -> Bool {
        return ts_tree_cursor_goto_parent(&cursor)
    }
    
    public func goToNextSibling() -> Bool {
        return ts_tree_cursor_goto_next_sibling(&cursor)
    }
    
    public func goToFirstChild() -> Bool {
        return ts_tree_cursor_goto_first_child(&cursor)
    }
    
    public func copy() -> SyntaxCursor {
        return SyntaxCursor(cursor: ts_tree_cursor_copy(&cursor))
    }
    
}
