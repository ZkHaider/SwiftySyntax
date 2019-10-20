//
//  ViewController.swift
//  TreeSitter-iOS
//
//  Created by Haider Khan on 8/25/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import UIKit
import SwiftySyntax

struct Colors {
    static let matteRed: UIColor = {
        return UIColor(red: 0.942, green: 0.566, blue: 0.498, alpha: 1.0)
    }()
    static let gold: UIColor = {
        return UIColor(red: 0.839, green: 0.78, blue: 0.463, alpha: 1.0)
    }()
}

class OldViewController: UIViewController {
    
    // MARK: - Attributes
    
    let sourceCode: String = """
    {
        "counter": 0,
        "images": [
            {
                "id": 10,
                "url": "https://someimage.com/image/12"
            }
        ]
    }
    """

    lazy var parser: SyntaxParser = {
        let parser = SyntaxParser()
        parser.parse(code: self.sourceCode)
        return parser
    }()
    
    // MARK: - Views
    
    var _view: OldView {
        return self.view as! OldView
    }
    
    // MARK: - Init
    
    public required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = OldView(frame: .zero)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard
            let tree = self.parser.tree
            else { return }
        
        let mutableAttributedString = NSMutableAttributedString(string: self.sourceCode)
        mutableAttributedString.addAttribute(.foregroundColor,
                                             value: UIColor.white,
                                             range: NSRange(location: 0, length: self.sourceCode.count))
        
        for match in self.parser.matches(with: .pairCombined, on: tree.rootNode) {
            for capture in match.captures {
                switch capture.captureType {
                case .pairKey:
                    let startByte = capture.node.startByte
                    let endByte = capture.node.endByte
                    let range = NSRange(location: startByte, length: endByte - startByte)
                    mutableAttributedString.addAttribute(
                        .foregroundColor,
                        value: Colors.matteRed,
                        range: range
                    )
                case .pairString:
                    let startByte = capture.node.startByte
                    let endByte = capture.node.endByte
                    let range = NSRange(location: startByte, length: endByte - startByte)
                    mutableAttributedString.addAttribute(
                        .foregroundColor,
                        value: Colors.matteRed,
                        range: range
                    )
                case .pairNumber:
                    let startByte = capture.node.startByte
                    let endByte = capture.node.endByte
                    let range = NSRange(location: startByte, length: endByte - startByte)
                    mutableAttributedString.addAttribute(
                        .foregroundColor,
                        value: Colors.gold,
                        range: range
                    )
                case .pairArray:
                    continue
                case .pairObject:
                    continue
                default: continue
                }
            }
        }
        
        
        self._view.textView.attributedText = mutableAttributedString
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

