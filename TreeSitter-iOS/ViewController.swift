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
        
        let parser = ts_parser_new()
        ts_parser_set_language(parser, tree_sitter_json())
        
        let sourceCode = """
        {
            "counter": 0
        }
        """
        
        let tree = ts_parser_parse_string(
            parser,
            nil,
            sourceCode,
            UInt32(sourceCode.count)
        )
        
        let rootNode: TSNode = ts_tree_root_node(tree)
        
        let pointer = ts_node_string(rootNode)!
        let sExpression = String(cString: pointer)
        
        print(parser)
        print(tree)
        print(rootNode)
        print(sExpression)
        print("✅")
    }


}

