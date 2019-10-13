//
//  Syntax.Tree.Point.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 10/12/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

struct Point<T> {
    let x: T
    let y: T
}

extension Point where T == Int {
    
    internal init(column: Int,
                  row: Int) {
        self.x = column
        self.y = row
    }
    
    internal var tsPoint: TSPoint {
        return TSPoint(
            row: UInt32(self.y),
            column: UInt32(self.x)
        )
    }
    
}
