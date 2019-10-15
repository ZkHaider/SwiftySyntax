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
    
    public typealias Element = Match
    
    // MARK: - Attributes
    
    let query: Query
    let queryCursorPointer: OpaquePointer?
    private var reusableMatch: TSQueryMatch = TSQueryMatch()
    
    internal init(with query: Queries,
                  on node: SyntaxNode) {
        self.query = query.query
        self.queryCursorPointer = ts_query_cursor_new()
        
        // Execute query
        ts_query_cursor_exec(
            self.queryCursorPointer,
            self.query.ptr,
            node.node
        )
    }
    
    // MARK: - IteratorProtocol - Next
    
    public mutating func next() -> Match? {
        while ts_query_cursor_next_match(
            self.queryCursorPointer,
            &self.reusableMatch) {
                
                let patternIndex: Int = Int(self.reusableMatch.pattern_index)
                let captureName = self.query.captureNames[patternIndex]
                
                if let captures = self.reusableMatch.captureValues,
                    let captureType = Queries.CaptureType(rawValue: captureName) {
                    
                    let match = Match(
                        id: Int(self.reusableMatch.id),
                        captureType: captureType,
                        captures: captures.compactMap {
                            Capture(node: $0.node, index: Int($0.index))
                        }
                    )
                    return match
                }
        }
        ts_query_cursor_delete(self.queryCursorPointer)
        return nil
    }
    
}

extension TSQueryMatch {
    
    public var captureValues: [TSQueryCapture]? {
        let captureCount = self.capture_count
        let captures = self.captures
        if captureCount > 0 {
            let buffer = UnsafeBufferPointer(start: captures,
                                             count: Int(captureCount))
            return Array(buffer)
        }
        return nil
    }
    
}
