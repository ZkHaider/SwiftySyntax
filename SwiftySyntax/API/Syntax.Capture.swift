//
//  Syntax.Capture.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 10/14/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

public struct Capture {
    
    let node: SyntaxNode
    let index: Int
    
    internal init(node ptr: TSNode,
                  index: Int) {
        self.node = SyntaxNode(node: ptr)
        self.index = index
    }
    
}
