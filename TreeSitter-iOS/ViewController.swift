//
//  ViewController.swift
//  TreeSitter-iOS
//
//  Created by Haider Khan on 10/19/19.
//  Copyright © 2019 zkhaider. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    // MARK: - Attributes
    
    // ...
    
    // MARK: - Views
    
    var _view: View {
        return self.view as! View
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
        self.view = View(frame: .zero)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}
