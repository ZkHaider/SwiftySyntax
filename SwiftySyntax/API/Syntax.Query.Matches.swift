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
                
                // Move this out to clean next function
                let patternIndex: Int = Int(self.reusableMatch.pattern_index)
                
                if let captures = self.reusableMatch.captureValues {
                    
                    // Create captures
                    let matchCaptures = captures.compactMap { queryCapture -> Capture? in
                        guard
                            queryCapture.index <= self.query.captureNames.count
                            else { return nil }
                        
                        let captureName = self.query.captureNames[Int(queryCapture.index)]
                        
                        guard
                            let captureType = Queries.CaptureType(rawValue: captureName)
                            else { return nil }
                        
                        return Capture(
                            node: queryCapture.node,
                            captureType: captureType
                        )
                    }
                    
                    // Return match
                    return Match(
                        id: Int(self.reusableMatch.id),
                        patternIndex: patternIndex,
                        captures: matchCaptures
                    )
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
