//
//  Syntax.Queries.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 10/14/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

public enum Queries {
    
    // MARK: - Objects
    
    case objectString
    case objectArray
    case objectNumber
    case objectObject
    
    
    // MARK: - Pairs
    
    case pairString
    case pairArray
    case pairNumber
    case pairObject
    case pairCombined
    
    internal var query: Query {
        switch self {
        case .objectString:
            return QueryRef.Object.objectStringQuery
        case .objectArray:
            return QueryRef.Object.objectArrayQuery
        case .objectNumber:
            return QueryRef.Object.objectNumberQuery
        case .objectObject:
            return QueryRef.Object.objectObjectQuery
        case .pairString:
            return QueryRef.Pair.pairStringQuery
        case .pairArray:
            return QueryRef.Pair.pairArrayQuery
        case .pairNumber:
            return QueryRef.Pair.pairNumberQuery
        case .pairObject:
            return QueryRef.Pair.pairObjectQuery
        case .pairCombined:
            return QueryRef.Pair.pairCombinedQuery
        }
    }
    
    /// Reusable Queries 
    
    private struct QueryRef {
        
        struct Object {
            
            static let objectStringQuery: Query = {
                createQuery(language: tree_sitter_json(), with: Source.Object.objectString)
            }()
            
            static let objectArrayQuery: Query = {
                return createQuery(language: tree_sitter_json(), with: Source.Object.objectArray)
            }()
            
            static let objectNumberQuery: Query = {
                return createQuery(language: tree_sitter_json(), with: Source.Object.objectNumber)
            }()
            
            static let objectObjectQuery: Query = {
                return createQuery(language: tree_sitter_json(), with: Source.Object.objectObject)
            }()
            
            static let objectCombinedQuery: Query = {
                let combinedQuerySource = [
                    Source.Object.objectString,
                    Source.Object.objectArray,
                    Source.Object.objectNumber,
                    Source.Object.objectObject
                ].joined(separator: "\n")
                return createQuery(language: tree_sitter_json(), with: combinedQuerySource)
            }()
            
        }
        
        struct Pair {
        
            static let pairStringQuery: Query = {
                createQuery(language: tree_sitter_json(), with: Source.Pair.pairString)
            }()
            
            static let pairArrayQuery: Query = {
                return createQuery(language: tree_sitter_json(), with: Source.Pair.pairArray)
            }()
            
            static let pairNumberQuery: Query = {
                return createQuery(language: tree_sitter_json(), with: Source.Pair.pairNumber)
            }()
            
            static let pairObjectQuery: Query = {
                return createQuery(language: tree_sitter_json(), with: Source.Pair.pairObject)
            }()
            
            static let pairCombinedQuery: Query = {
                let combinedQuerySource = [
                    Source.Pair.pairString,
                    Source.Pair.pairArray,
                    Source.Pair.pairNumber,
                    Source.Pair.pairObject
                ].joined(separator: "\n")
                return createQuery(language: tree_sitter_json(), with: combinedQuerySource)
            }()
            
        }
        
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
    
    public enum CaptureType: String {
        
        // MARK: - Object
        
        case objectString   = "object.string"
        case objectArray    = "object.array"
        case objectNumber   = "object.number"
        case objectObject   = "object.object"
        
        // MARK: - Pair
        
        case pairKey        = "pair.key"
        case pairString     = "pair.value.string"
        case pairArray      = "pair.value.array"
        case pairNumber     = "pair.value.number"
        case pairObject     = "pair.value.object"
    }
    
}
