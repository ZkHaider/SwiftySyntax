//
//  Swift.Parsing.Tests.swift
//  SwiftySyntaxTests
//
//  Created by Haider Khan on 2/1/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import XCTest
@testable import SwiftySyntax

final class ViewController: UIViewController {
    
    // MARK: - Init
    
    required init() {
        super.init(nibName: nil, bundle: nil)
        initialize()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension ViewController {
    fileprivate func initialize() {
        func prepare() {
            
        }
        prepare()
    }
}

final class SwiftParsingTests: XCTestCase {
    
    let sourceCode: String = """
    final class MyClass {

    }

    """
    
    let complexSourceCode: String = """
    import UIKit

    final class ViewController: UIViewController {
        
        // MARK: - Init
        
        required init() {
            super.init(nibName: nil, bundle: nil)
            initialize()
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Lifecycle
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
    }

    extension ViewController {
        fileprivate func initialize() {
            func prepare() {
                
            }
            prepare()
        }
    }

    """
    
    func testSwiftParse() {
        let parser = SyntaxParser(
            config: DefaultSyntaxConfig(language: .swift)
        )
        parser.parse(code: sourceCode)
        if let expression = parser.sExpression() {
            assert(expression == "(program (class_declaration (modifier) (identifier)))")
        } else {
            assert(false)
        }
    }
    
    func testSwiftParseTraverse() {
        
        let parser = SyntaxParser(
            config: DefaultSyntaxConfig(language: .swift)
        )
        parser.parse(code: sourceCode)
        if let syntaxTree = parser.tree {
            let rootNode = syntaxTree.rootNode
            let cursor = rootNode.getCursor()
            
            cursor.preorderTraverse(node: rootNode) { (node) in
                // Perform effect
                if let nodeSyntaxString = node.type,
                    let symbol = SwiftSymbols.symbolMap[nodeSyntaxString] {
                    switch symbol {
                    case .program:
                        assert(nodeSyntaxString == "program")
                    case .modifier:
                        assert(nodeSyntaxString == "modifier")
                    case .class:
                        assert(nodeSyntaxString == "class")
                    case .identifier:
                        assert(nodeSyntaxString == "identifier") // :
                    case .classDeclaration:
                        assert(nodeSyntaxString == "class_declaration")
                    case .openCurlyBrace:
                        assert(nodeSyntaxString == "{")
                    case .closedCurlyBrace:
                        assert(nodeSyntaxString == "}")
                    case .final:
                        assert(nodeSyntaxString == "final")
                    default: ()
                    }
                }
            }
        }
    }
    
    func testComplexSwiftParseTraverse() {
        
        let parser = SyntaxParser(
            config: DefaultSyntaxConfig(language: .swift)
        )
        parser.parse(code: complexSourceCode)
        if let syntaxTree = parser.tree {
            let rootNode = syntaxTree.rootNode
            let cursor = rootNode.getCursor()
            
            cursor.preorderTraverse(node: rootNode) { (node) in
                // Perform effect
                if let nodeSyntaxString = node.type,
                    let symbol = SwiftSymbols.symbolMap[nodeSyntaxString] {
                    switch symbol {
                    case .program:
                        assert(nodeSyntaxString == "program")
                    case .importDeclaration:
                        assert(nodeSyntaxString == "import_declaration")
                    case .import:
                        assert(nodeSyntaxString == "import")
                    case .modifier:
                        assert(nodeSyntaxString == "modifier")
                    case .class:
                        assert(nodeSyntaxString == "class")
                    case .identifier:
                        assert(nodeSyntaxString == "identifier")
                    case .semicolon:
                        assert(nodeSyntaxString == ":")
                    case .classDeclaration:
                        assert(nodeSyntaxString == "class_declaration")
                    case .openCurlyBrace:
                        assert(nodeSyntaxString == "{")
                    case .closedCurlyBrace:
                        assert(nodeSyntaxString == "}")
                    case .final:
                        assert(nodeSyntaxString == "final")
                    case .comment:
                        assert(nodeSyntaxString == "comment")
                    case .`init`:
                        assert(nodeSyntaxString == "init")
                    case .dot:
                        assert(nodeSyntaxString == ".")
                    case .type:
                        assert(nodeSyntaxString == "type")
                    case .comma:
                        assert(nodeSyntaxString == ",")
                    default: ()
                    }
                }
            }
        }
    }
    
}
