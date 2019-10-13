//
//  Syntax.Tree.Input.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 10/12/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

public struct InputEdit {
    let startByte: Int
    let oldEndByte: Int
    let newEndByte: Int
    let startPoint: Point<Int>
    let oldEndPoint: Point<Int>
    let newEndPoint: Point<Int>
}

extension InputEdit: Hashable {
    
    public static func ==(lhs: InputEdit,
                          rhs: InputEdit) -> Bool {
        if lhs.startByte != rhs.startByte {
            return false
        }
        if lhs.oldEndByte != rhs.oldEndByte {
            return false
        }
        if lhs.newEndByte != rhs.newEndByte {
            return false
        }
        if lhs.startPoint.x != rhs.startPoint.x {
            return false
        }
        if lhs.startPoint.y != rhs.startPoint.y {
            return false
        }
        if lhs.oldEndPoint.x != rhs.oldEndPoint.x {
            return false
        }
        if lhs.oldEndPoint.y != rhs.oldEndPoint.y {
            return false
        }
        if lhs.newEndPoint.x != rhs.newEndPoint.x {
            return false
        }
        if lhs.newEndPoint.y != rhs.newEndPoint.y {
            return false
        }
        return true
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.startByte)
        hasher.combine(self.oldEndByte)
        hasher.combine(self.newEndByte)
        hasher.combine(self.startPoint.x)
        hasher.combine(self.startPoint.y)
        hasher.combine(self.oldEndPoint.x)
        hasher.combine(self.oldEndPoint.y)
        hasher.combine(self.newEndPoint.x)
        hasher.combine(self.newEndPoint.y)
    }
    
}

extension InputEdit {
    
    internal var tsInputEdit: TSInputEdit {
        return TSInputEdit(
            start_byte: UInt32(self.startByte),
            old_end_byte: UInt32(self.oldEndByte),
            new_end_byte: UInt32(self.newEndByte),
            start_point: self.startPoint.tsPoint,
            old_end_point: self.oldEndPoint.tsPoint,
            new_end_point: self.newEndPoint.tsPoint
        )
    }
    
}
