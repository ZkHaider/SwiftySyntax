//
//  Syntax.Queries.Source.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 10/14/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

/// Reusable S-Expressions for queries 
extension Queries {
    
    internal struct Source {
        
        typealias Value = String
        
        struct Object {
            static let objectString: String = """
            (object
                (pair
                    (string)
                    (string)) @object.string)
            """
            
            static let objectArray: String = """
            (object
                (pair
                    (string)
                    (array)) @object.array)
            """
            
            static let objectNumber: String = """
            (object
                (pair
                    (string)
                    (number)) @object.number)
            """
            
            static let objectObject: String = """
            (object
                (pair
                    (string)
                    (object)) @object.object)
            """
        }
        
        struct Pair {
            static let pairString: String = """
            (pair
                (string) @pair.key
                (string) @pair.value.string)
            """
            static let pairNumber: String = """
            (pair
                (string) @pair.key
                (number) @pair.value.number)
            """
            static let pairArray: String = """
            (pair
                (string) @pair.key
                (array) @pair.value.array)
            """
            static let pairObject: String = """
            (pair
                (string) @pair.key
                (object) @pair.value.object)
            """
        }
        
    }
    
}
