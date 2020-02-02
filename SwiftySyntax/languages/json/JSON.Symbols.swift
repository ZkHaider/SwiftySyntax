//
//  JSON.Symbols.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 10/12/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

public enum JSONSymbols: String {
    case openCurlyBrace     = "{"
    case comma              = ","
    case closedCurlyBrace   = "}"
    case semicolon          = ":"
    case openBracket        = "["
    case closedBracket      = "]"
    case escape             = "\\"
    case escapeSequence     = "escape_sequence"
    case number             = "number"
    case `true`             = "true"
    case `false`            = "false"
    case `null`             = "null"
    case value              = "value"
    case object             = "object"
    case pair               = "pair"
    case array              = "array"
    case string             = "string"
    case stringContent      = "stringContent"
}

extension JSONSymbols: Symbols {
    
    public static let allValues: [Self] = {
        return Array(Self.allCases)
    }()
    
    public static let symbolMap: [String : JSONSymbols] = {
        return allValues.reduce(into: [:]) { (map, symbol) in
            map[symbol.rawValue] = symbol
        }
    }()
    
}
