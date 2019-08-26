//
//  Tree.Configuration.swift
//  SwiftySyntax
//
//  Created by Haider Khan on 8/25/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation

public protocol SyntaxConfiguration {
    var language: SyntaxLanguage { get }
}

public struct DefaultSyntaxConfig: SyntaxConfiguration {
    public let language: SyntaxLanguage 
}

extension DefaultSyntaxConfig {
    public static var defaultValue: DefaultSyntaxConfig {
        return DefaultSyntaxConfig(language: .json)
    }
}
