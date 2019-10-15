//
//  Syntax.Queries.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 10/14/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

public enum Queries {
    
    case pairString
    case pairArray
    case pairNumber
    case pairObject
    case pairCombined
    
    internal var query: Query {
        switch self {
        case .pairString:
            return QueryRef.pairStringQuery
        case .pairArray:
            return QueryRef.pairArrayQuery
        case .pairNumber:
            return QueryRef.pairNumberQuery
        case .pairObject:
            return QueryRef.pairObjectQuery
        case .pairCombined:
            return QueryRef.pairCombinedQuery
        }
    }
    
    /// Reusable Queries 
    
    private struct QueryRef {
        
        static let pairStringQuery: Query = {
            createQuery(language: tree_sitter_json(), with: Source.pairString)
        }()
        
        static let pairArrayQuery: Query = {
            return createQuery(language: tree_sitter_json(), with: Source.pairArray)
        }()
        
        static let pairNumberQuery: Query = {
            return createQuery(language: tree_sitter_json(), with: Source.pairNumber)
        }()
        
        static let pairObjectQuery: Query = {
            return createQuery(language: tree_sitter_json(), with: Source.pairObject)
        }()
        
        static let pairCombinedQuery: Query = {
            let combinedQuerySource = [
                Source.pairString,
                Source.pairArray,
                Source.pairNumber,
                Source.pairObject
            ].joined(separator: "\n")
            return createQuery(language: tree_sitter_json(), with: combinedQuerySource)
        }()
        
        private static func createQuery(language: UnsafePointer<TSLanguage>!,
                                        with source: Source.Value) -> Query {
            var errorOffset: UInt32 = 0
            var errorType = TSQueryError(rawValue: 0)
            let query = ts_query_new(
                language,
                source,
                UInt32(source.count),
                &errorOffset,
                &errorType
            )
            return Query(ptr: query)
        }
        
    }
    
    internal enum CaptureType: String {
        case pairString = "pair.string"
        case pairArray  = "pair.array"
        case pairNumber = "pair.number"
        case pairObject = "pair.object"
    }
    
}
