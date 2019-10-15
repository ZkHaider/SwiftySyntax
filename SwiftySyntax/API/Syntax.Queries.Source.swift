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
        
        static let pairString: String = """
        (object
            (pair
                (string)
                (string)) @pair.string)
        """
        
        static let pairArray: String = """
        (object
            (pair
                (string)
                (array)) @pair.array)
        """
        
        static let pairNumber: String = """
        (object
            (pair
                (string)
                (number)) @pair.number)
        """
        
        static let pairObject: String = """
        (object
            (pair
                (string)
                (object)) @pair.object)
        """
        
    }
    
}
