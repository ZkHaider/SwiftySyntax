//
//  Tree.Parser.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 8/25/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

public final class SyntaxParser {
    
    // MARK: - Pointer
    
    internal let parser: OpaquePointer

    // MARK: - Attributes
    
    public let config: SyntaxConfiguration

    public var tree: SyntaxTree? {
        didSet {
            guard
                let _ = oldValue
                else {
                    return
            }
            
        }
    }
    
    // MARK: - Init
    
    public init(config: SyntaxConfiguration = DefaultSyntaxConfig.defaultValue) {
        self.config = config
        self.parser = ts_parser_new()
        switch config.language {
        case .json:
            ts_parser_set_language(self.parser, tree_sitter_json())
        case .swift:
            ts_parser_set_language(self.parser, tree_sitter_swift())
//        case .python:
//            ts_parser_set_language(self.parser, tree_sitter_python())
//        case .php:
//            ts_parser_set_language(self.parser, tree_sitter_php())
//        case .rust:
//            ts_parser_set_language(self.parser, tree_sitter_rust())
        }
    }
    
    // MARK: - Parser Functions
    
    public func parse(code string: String) {
        guard
            let oldTree = self.tree,
            let newTreePointer = ts_parser_parse(self.parser,
                                                 oldTree.tree,
                                                 TSInput.init())
            else {
                if let newTreePointer = ts_parser_parse_string(self.parser,
                                                               nil,
                                                               string,
                                                               UInt32(string.count)) {
                    self.tree = SyntaxTree(pointer: newTreePointer)
                }
                return
        }
        ts_tree_delete(oldTree.tree)
        self.tree = nil
        self.tree = SyntaxTree(pointer: newTreePointer)
    }
    
    public func reParse(code string: String,
                        with edit: InputEdit) {
        
        guard
            let oldTree = self.tree
            else {
                self.parse(code: string)
                return
        }
        
        // Edit
        
        var tsEdit = edit.tsInputEdit
        ts_tree_edit(
            oldTree.tree,
            &tsEdit
        )
        
        var node = oldTree.rootNode.node
        ts_node_edit(
            &node,
            &tsEdit
        )
        
        // Reparse
        
        if
            let newTree = ts_parser_parse_string(
                self.parser,
                oldTree.tree,
                string,
                UInt32(string.count)
            ) {
            self.tree = SyntaxTree(pointer: newTree)
        }
    }
    
    public func sExpression(for node: TSNode? = nil) -> String? {
        guard
            let node = node,
            let pointer = ts_node_string(node)
            else {
                if let tree = self.tree {
                    let rootNode = ts_tree_root_node(tree.tree)
                    if let pointer = ts_node_string(rootNode) {
                        return String(cString: pointer)
                    } else {
                        return nil
                    }
                }
                return nil
        }
        return String(cString: pointer)
    }
    
    // MARK: - Query
    
    public func matches(with query: Queries,
                        on node: SyntaxNode) -> MatchesIterator {
        return MatchesIterator(with: query,
                               on: node)
    }
    
    // MARK: - Deinit
    
    deinit {
        if let tree = self.tree {
            ts_tree_delete(tree.tree)
        }
        ts_parser_delete(self.parser)
    }
    
}
