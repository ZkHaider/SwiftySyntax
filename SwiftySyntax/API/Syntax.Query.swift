//
//  Syntax.Query.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 10/14/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

/// Wrapper for TSQuery which is an OpaquePointer?
internal class Query {
    
    // MARK: - Attributes
    
    internal let ptr: OpaquePointer?
    
    let captureNames: [String]
    let stringNames: [String]
    
    // MARK: - Init
    
    init(ptr: OpaquePointer?) {
        self.ptr = ptr
        
        let stringCount = ts_query_string_count(ptr)
        let captureCount = ts_query_capture_count(ptr)
        
        // TODO: Pattern count is for text predicates - implement later
//        let patternCount = ts_query_pattern_count(ptr)
        
        // Build a vector of strings to store the capture names.
        let captureNames = (0..<captureCount).compactMap { (captureId) -> String? in
            
            var length: UInt32 = 0
            guard
                let name = ts_query_capture_name_for_id(
                    ptr,
                    UInt32(captureId),
                    &length
                )
                else {
                    return nil
            }
            return String(cString: name)
        }
        
        self.captureNames = captureNames
        
        // Build a vector of strings to represent literal values used in predicates.
        let stringNames = (0..<stringCount).compactMap { (stringId) -> String? in
            
            var length: UInt32 = 0
            guard
                let name = ts_query_string_value_for_id(
                    ptr,
                    UInt32(stringId),
                    &length
                )
                else {
                    return nil
            }
            return String(cString: name)
        }
        
        self.stringNames = stringNames
    }
    
}
