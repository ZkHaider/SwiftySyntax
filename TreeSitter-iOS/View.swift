//
//  View.swift
//  TreeSitter-iOS
//
//  Created by Haider Khan on 10/19/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation
import SwiftySyntax
import UIKit

final class View: UIView {
    
    // MARK: - Views
    
    let textView: SyntaxTextView = {
        return SyntaxTextView(frame: .zero, language: .json)
    }()
    
    // MARK: - Init
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        self.addSubview(self.textView)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = self.bounds
        
        let safeAreaInsets = self.safeAreaInsets
        let height = bounds.height - (safeAreaInsets.top + safeAreaInsets.bottom)
        self.textView.frame = bounds
            .divided(atDistance: height / 2.0, from: .minXEdge)
            .slice
            .offsetBy(dx: 0.0, dy: safeAreaInsets.top)
    }
    
}
