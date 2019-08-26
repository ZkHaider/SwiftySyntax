//
//  Tree.Configuration.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 8/25/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

public protocol TreeConfiguration {
    var language: TreeLanguage { get }
}

public struct DefaultConfig: TreeConfiguration {
    public let language: TreeLanguage 
}
