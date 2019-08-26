//
//  Tree.Parser.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 8/25/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

public final class TreeParser {
    
    // MARK: - Pointer
    
    internal let parser: OpaquePointer
    
    // MARK: - Attributes
    
    public let config: TreeConfiguration
    
    public var rootNode: TSNode {
        return ts_tree_root_node(self.parser)
    }
    
    // MARK: - Init
    
    public init(config: TreeConfiguration) {
        self.config = config
        self.parser = ts_parser_new()
        switch config.language {
        case .json:
            ts_parser_set_language(self.parser, tree_sitter_json())
//        case .python:
//            ts_parser_set_language(self.parser, tree_sitter_python())
//        case .php:
//            ts_parser_set_language(self.parser, tree_sitter_php())
//        case .rust:
//            ts_parser_set_language(self.parser, tree_sitter_rust())
        }
    }
    
    // MARK: - Parser Functions
    
    public func sExpression(for node: TSNode) -> String? {
        guard
            let pointer = ts_node_string(node)
            else { return nil }
        return String(cString: pointer)
    }
    
}
