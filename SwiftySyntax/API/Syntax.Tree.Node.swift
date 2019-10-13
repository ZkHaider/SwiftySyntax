//
//  Syntax.Tree.Node.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 8/27/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

public struct SyntaxPoint {
    public let column: Int
    public let row: Int
    
    public init(column: Int,
                row: Int) {
        self.column = column
        self.row = row
    }
    
    public init(column: UInt32,
                row: UInt32) {
        self.column = Int(column)
        self.row = Int(row)
    }
}

public final class SyntaxNode {
    
    // MARK: - Pointer
    
    internal let node: TSNode
    
    // MARK: - Attributes
    
    public var startByte: Int {
        return Int(ts_node_start_byte(self.node))
    }
    
    public var endByte: Int {
        return Int(ts_node_end_byte(self.node))
    }
    
    public var startPoint: SyntaxPoint {
        let point = ts_node_start_point(self.node)
        return SyntaxPoint(column: point.column, row: point.row)
    }
    
    public var endPoint: SyntaxPoint {
        let point = ts_node_end_point(self.node)
        return SyntaxPoint(column: point.column, row: point.row)
    }
    
    public var childCount: Int {
        let count = ts_node_child_count(self.node)
        return Int(count)
    }
    
    public var children: [SyntaxNode] {
        let count = self.childCount
        var children: [SyntaxNode] = []
        for i in 0..<count {
            children.append(
                SyntaxNode(
                    node: ts_node_child(self.node, UInt32(i))
                )
                
            )
        }
        return children
    }
    
    public var type: String? {
        guard
            let pointer =  ts_node_type(self.node)
            else { return nil }
        return String(cString: pointer)
    }
    
    public var symbol: Int {
        let symbol = ts_node_symbol(self.node)
        return Int(symbol)
    }
    
    public var nodeString: String? {
        guard
            let pointer = ts_node_string(self.node)
            else { return nil }
        return String(cString: pointer)
    }
    
    public var isNamed: Bool {
        return ts_node_is_named(self.node)
    }
    
    public var isMissing: Bool {
        return ts_node_is_missing(self.node)
    }
    
    public var isNull: Bool {
        return ts_node_is_null(self.node)
    }
    
    public var isExtra: Bool {
        return ts_node_is_extra(self.node)
    }
    
    public var hasChanges: Bool {
        return ts_node_has_changes(self.node)
    }
    
    public var parent: SyntaxNode {
        return SyntaxNode(node: ts_node_parent(self.node))
    }
    
    // MARK: - Init
    
    public init(node: TSNode) {
        self.node = node
    }
    
    // MARK: - Node Functions
    
    public func getCursor() -> SyntaxCursor {
        let cursor = ts_tree_cursor_new(self.node)
        return SyntaxCursor(cursor: cursor)
    }
    
}

extension SyntaxNode: Equatable {

    public static func ==(lhs: SyntaxNode,
                          rhs: SyntaxNode) -> Bool {
        return ts_node_eq(lhs.node, rhs.node)
    }

}

extension SyntaxNode: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        let childCount = self.childCount
        let type = self.type ?? ""
        let nodeString = self.nodeString ?? ""
        let startByte = self.startByte
        let endByte = self.endByte
        let startPoint = self.startPoint
        let endPoint = self.endPoint
        return """
        Node:
        \tchildCount: \(childCount)
        \ttype: \(type)
        \tdescription: \(nodeString)
        \tstartByte: \(startByte)
        \tendByte: \(endByte)
        \tstartPoint: (column: \(startPoint.column), row: \(startPoint.row))
        \tendPoint: (column: \(endPoint.column), row: \(endPoint.row))
        """
    }
    
}
