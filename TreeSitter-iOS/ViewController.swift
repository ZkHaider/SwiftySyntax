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
        
        /*
         Prints:
         (value <-- Go To First Child
            (object <-- Go To First Child
                (pair <-- Go to First Child
                    (string (string_content)) <-- Go To Next Sibling
                    (number) <-- Go To Parent <-- Go To Next Sibling
                )
                (pair <-- Go To First Child
                    (string (string_content)) <-- Go To Next Sibling
                    (array <-- Go To First Child
                        (object <-- Go To First Child
                            (pair <-- Go To First Child
                                (string (string_content)) <-- Go To Next Sibling
                                (number) <-- Go To Parent <-- Go To Next Sibling
                            )
                            (pair <-- Go To First Child
                                (string (string_content)) <-- Go To Next Sibling
                                (string (string_content)) <-- Go To Parent <-- Go To Parent <-- Go To Parent
                            )
                        )
                    )
                )
            )
         )
         */
        
        if let syntaxTree = parser.tree {
            let rootNode = syntaxTree.rootNode
            let cursor = rootNode.getCursor()
            
            cursor.preorderTraverse(node: rootNode) { (node) in
                // Perform effect
                print(node)
            }
        }
    }


}

