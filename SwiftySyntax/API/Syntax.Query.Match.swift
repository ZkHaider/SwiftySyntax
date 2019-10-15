//
//  Syntax.Query.Match.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 10/14/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

public struct Match {
    public let id: Int
    public let patternIndex: Int
    public let captures: [Capture]
}
