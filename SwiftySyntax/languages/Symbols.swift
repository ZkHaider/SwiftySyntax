//
//  Symbols.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 2/1/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import Foundation

public protocol Symbols: Hashable, CaseIterable {
    static var allValues: [Self] { get }
    static var symbolMap: [String: Self] { get }
}
