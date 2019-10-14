//
//  Syntax.Query.Cursor.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 10/13/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

public struct MatchesIterator: IteratorProtocol, Sequence {
    
    // MARK: - IteratorProtocol - Element
    
    public typealias Element = TSQueryMatch
    
    // MARK: - Attributes
    
    let queryCursorPointer: OpaquePointer?
    private var reusableMatch: TSQueryMatch = TSQueryMatch()
    
    internal init(with query: Query,
                  on node: SyntaxNode) {
        self.queryCursorPointer = ts_query_cursor_new()
    
        // Create query
        var errorOffset: UInt32 = 0
        var errorType = TSQueryError(rawValue: 0)
        let query = ts_query_new(
            query.language.tsLanguage,
            query.sourceQuery,
            query.sourceLength,
            &errorOffset,
            &errorType
        )
        
        // Execute query
        ts_query_cursor_exec(
            self.queryCursorPointer,
            query,
            node.node
        )
    }
    
    // MARK: - IteratorProtocol - Next
    
    public mutating func next() -> TSQueryMatch? {
        while ts_query_cursor_next_match(
            self.queryCursorPointer,
            &self.reusableMatch) {
                return self.reusableMatch
        }
        ts_query_cursor_delete(self.queryCursorPointer)
        return nil
    }
    
}
