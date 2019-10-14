//
//  Syntax.Query.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 10/13/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

public struct Query {
    
    let language: SyntaxLanguage
    let sourceQuery: String
    internal let sourceLength: UInt32
    
    public init(language: SyntaxLanguage,
                sourceQuery: String) {
        self.language = language
        self.sourceQuery = sourceQuery
        self.sourceLength = UInt32(sourceQuery.count)
    }
    
}
