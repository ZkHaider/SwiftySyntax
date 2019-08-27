//
//  ViewController.swift
//  TreeSitter-iOS
//
//  Created by Haider Khan on 8/25/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import UIKit
import SwiftySyntax

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sourceCode = """
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
        
        let parser = SyntaxParser()
        parser.parse(code: sourceCode)
        if let expression = parser.sExpression() {
            print(expression)
        }
        
        if let syntaxTree = parser.tree {
            let rootNode = syntaxTree.rootNode
            let cursor = rootNode.getCursor()
            print(rootNode)
            var traversing: Bool = true
            while (traversing) {
                
                // First check if we have a child
                traversing = cursor.goToNextSibling()
                if traversing == false {
                    traversing = cursor.goToNextSibling()
                    traversing = cursor.goToFirstChild()
                }
                
                // Get the current node -> print
                let currentNode = cursor.currentNode()
                print(currentNode)
            }
        }
    }


}

