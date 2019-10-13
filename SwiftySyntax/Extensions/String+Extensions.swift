//
//  String+Extensions.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 10/12/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

extension String {
    
    subscript(r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.startIndex)
            let endIndex = self.index(self.startIndex, offsetBy: r.endIndex)
            return String(self[startIndex..<endIndex])
        }
    }
    
    func substring(startIndex: Int, length: Int) -> String {
        let start = self.startIndex.utf16Offset(in: self).advanced(by: startIndex)
        let end = self.startIndex.utf16Offset(in: self).advanced(by: startIndex + length)
        return self[start..<end]
    }
    
    subscript(i: Int) -> Character {
        get {
            let index = self.index(self.startIndex, offsetBy: i)
            return self[index]
        }
    }
    
}

extension Substring {
    
    subscript(r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.startIndex)
            let endIndex = self.index(self.startIndex, offsetBy: r.endIndex)
            return String(self[startIndex..<endIndex])
        }
    }
    
    func substring(startIndex: Int, length: Int) -> String {
        let start = self.startIndex.utf16Offset(in: self).advanced(by: startIndex)
        let end = self.startIndex.utf16Offset(in: self).advanced(by: startIndex + length)
        return self[start..<end]
    }
    
    subscript(i: Int) -> Character {
        get {
            let index = self.index(self.startIndex, offsetBy: i)
            return self[index]
        }
    }
    
}
