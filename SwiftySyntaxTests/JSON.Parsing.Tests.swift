//
//  JSON.Parsing.Tests.swift
//  SwiftySyntaxTests
//
//  Created by Haider Khan on 10/11/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import XCTest
import simd
@testable import SwiftySyntax

final class JSONParsingTests: XCTestCase {
    
    let sourceCode: String = """
    {
        "counter": 0,
        "images": [
            {
                "id": 10,
                "url": "https://someimage.com/image/12"
            }
        ]
    }
    """
    
    let notPrettySourceCode: String = "{\"counter\": 0,\"images\":[{\"id\": 10,\"url\": \"https://someimage.com/image/12\"}]}"
    
    func testJSONParse() {
        let parser = SyntaxParser()
        parser.parse(code: notPrettySourceCode)
        if let expression = parser.sExpression() {
            assert(expression == "(value (object (pair (string (string_content)) (number)) (pair (string (string_content)) (array (object (pair (string (string_content)) (number)) (pair (string (string_content)) (string (string_content))))))))")
        } else {
            assert(false)
        }
    }
    
    func testPrettyJSONParseTraverse() {
        
        let parser = SyntaxParser()
        parser.parse(code: sourceCode)
        if let syntaxTree = parser.tree {
            let rootNode = syntaxTree.rootNode
            let cursor = rootNode.getCursor()
            
            cursor.preorderTraverse(node: rootNode) { (node) in
                // Perform effect
                if let nodeSyntaxString = node.type,
                    let symbol = JSONSymbols.symbolMap[nodeSyntaxString] {
                    switch symbol {
                    case .openCurlyBrace:
                        let substring = self.sourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .comma:
                        let substring = self.sourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .closedCurlyBrace:
                        let substring = self.sourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .semicolon:
                        let substring = self.sourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .openBracket:
                        let substring = self.sourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .closedBracket:
                        let substring = self.sourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .escape:
                        let substring = self.sourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .escapeSequence:
                        let substring = self.sourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .number:
                        let substring = self.sourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .true:
                        let substring = self.sourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .false:
                        let substring = self.sourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .null:
                        let substring = self.sourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .value:
                        let substring = self.sourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .object:
                        let substring = self.sourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .pair:
                        let substring = self.sourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .array:
                        let substring = self.sourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .string:
                        let substring = self.sourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .stringContent:
                        let substring = self.sourceCode[node.startByte..<node.endByte]
                        print(substring)
                    @unknown default:
                        let substring = self.sourceCode[node.startByte..<node.endByte]
                        print(substring)
                    }
                }
            }
        }
    }
    
    func testNotPrettyJSONParseTraverse() {
        let parser = SyntaxParser()
        parser.parse(code: notPrettySourceCode)
        if let syntaxTree = parser.tree {
            let rootNode = syntaxTree.rootNode
            let cursor = rootNode.getCursor()
            
            cursor.preorderTraverse(node: rootNode) { (node) in
                // Perform effect
                if let nodeSyntaxString = node.type,
                    let symbol = JSONSymbols.symbolMap[nodeSyntaxString] {
                    switch symbol {
                    case .openCurlyBrace:
                        let substring = self.notPrettySourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .comma:
                        let substring = self.notPrettySourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .closedCurlyBrace:
                        let substring = self.notPrettySourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .semicolon:
                        let substring = self.notPrettySourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .openBracket:
                        let substring = self.notPrettySourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .closedBracket:
                        let substring = self.notPrettySourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .escape:
                        let substring = self.notPrettySourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .escapeSequence:
                        let substring = self.notPrettySourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .number:
                        let substring = self.notPrettySourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .true:
                        let substring = self.notPrettySourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .false:
                        let substring = self.notPrettySourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .null:
                        let substring = self.notPrettySourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .value:
                        let substring = self.notPrettySourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .object:
                        let substring = self.notPrettySourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .pair:
                        let substring = self.notPrettySourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .array:
                        let substring = self.notPrettySourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .string:
                        let substring = self.notPrettySourceCode[node.startByte..<node.endByte]
                        print(substring)
                    case .stringContent:
                        let substring = self.notPrettySourceCode[node.startByte..<node.endByte]
                        print(substring)
                    @unknown default:
                        let substring = self.notPrettySourceCode[node.startByte..<node.endByte]
                        print(substring)
                    }
                }
            }
        }
    }
    
    func testJSONParseAndEdit() {
        
        let parser = SyntaxParser()
        parser.parse(code: sourceCode)
        
        // Print sExpression
        guard
            let oldExpression = parser.sExpression()
            else {
                assertionFailure()
                return
        }
        
        print(oldExpression)
        
        let modifiedSourceCode = """
        {
            "images": [
                {
                    "id": 10,
                    "url": "https://someimage.com/image/12"
                }
            ]
        }
        """
        
        parser.reParse(
            code: modifiedSourceCode,
            with: InputEdit(
                startByte: 0,
                oldEndByte: 138,
                newEndByte: 119,
                startPoint: Point(
                    column: 0,
                    row: 0
                ),
                oldEndPoint: Point(
                    column: 1,
                    row: 8
                ),
                newEndPoint: Point(
                    column: 1,
                    row: 7
                )
            )
        )
        
        guard
            let newExpression = parser.sExpression()
            else {
                assertionFailure()
                return
        }
        
        assert(
            oldExpression == "(value (object (pair (string (string_content)) (number)) (pair (string (string_content)) (array (object (pair (string (string_content)) (number)) (pair (string (string_content)) (string (string_content))))))))" &&
            newExpression == "(value (object (pair (string (string_content)) (array (object (pair (string (string_content)) (number)) (pair (string (string_content)) (string (string_content))))))))" &&
            oldExpression != newExpression
        )
    }
    
    func testParsingLargeJSON() {
        
        let startTime = CFAbsoluteTimeGetCurrent()
        
        let parser = SyntaxParser()
        parser.parse(code: sampleJSON)
        guard
            let rootNode = parser.tree?.rootNode
            else {
                assertionFailure()
                return
        }
        let cursor = rootNode.getCursor()
        cursor.preorderTraverse(node: rootNode) { (node) in
            print(node)
        }
        
        let endTime = CFAbsoluteTimeGetCurrent()
        
        print("✅ finished in \(endTime - startTime) seconds")
    }
    
    func testObjectQuery() {
        
        let querySource: String = """
        (object
            (pair) @pair)
        """
        
        let syntaxParser = SyntaxParser()
        syntaxParser.parse(code: self.sourceCode)
        
        var errorOffset: UInt32 = 0
        var errorType = TSQueryError(rawValue: 0)
        guard
            let tree = syntaxParser.tree,
            let queryCursor = ts_query_cursor_new(),
            let query = ts_query_new(
                tree_sitter_json(),
                querySource,
                UInt32(querySource.count),
                &errorOffset,
                &errorType
            )
            else {
                assertionFailure()
                return
        }
        
        ts_query_cursor_exec(queryCursor,
                             query,
                             tree.rootNode.node)
        
        var match: TSQueryMatch = TSQueryMatch()
        while ts_query_cursor_next_match(
            queryCursor,
            &match) {
                print(match)
        }
    }
    
    func testMatchesIterator() {
        
        let parser = SyntaxParser()
        parser.parse(code: self.sourceCode)
        
        guard
            let tree = parser.tree
            else {
                assertionFailure()
                return
        }
        
        let matches = parser.matches(with: Queries.pairCombined,
                                     on: tree.rootNode)
        
        for match in matches {
            for capture in match.captures {
                switch match.captureType {
                case .pairString:
                    let subString = self.sourceCode[capture.node.startByte..<capture.node.endByte]
                    print(subString)
                case .pairNumber:
                    let subString = self.sourceCode[capture.node.startByte..<capture.node.endByte]
                    print(subString)
                case .pairObject:
                    let subString = self.sourceCode[capture.node.startByte..<capture.node.endByte]
                    print(subString)
                case .pairArray:
                    let subString = self.sourceCode[capture.node.startByte..<capture.node.endByte]
                    print(subString)
                }
            }
        }
    }
    
    func testPairQuery() {
     
        let parser = SyntaxParser()
        parser.parse(code: self.sourceCode)
        
        guard
            let tree = parser.tree
            else {
                assertionFailure()
                return
        }
        
        let matches = parser.matches(with: Queries.pairObject,
                                     on: tree.rootNode)
        
        for match in matches {
            print(match)
        }
    }
    
    func testMeasureOnTraversing() {
        
        measure {
            let parser = SyntaxParser()
            parser.parse(code: sampleJSON)
            guard
                let rootNode = parser.tree?.rootNode
                else {
                    assertionFailure()
                    return
            }
            let cursor = rootNode.getCursor()
            cursor.preorderTraverse(node: rootNode) { (node) in
                print(node)
            }
        }
        
    }
    
}
