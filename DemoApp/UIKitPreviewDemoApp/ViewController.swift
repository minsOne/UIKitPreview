//
//  ViewController.swift
//  UIKitPreviewDemoApp
//
//  Created by minsOne on 2023/08/20.
//

import SwiftUI
import UIKit
import UIKitPreview

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let label = UILabel(frame: .init(x: 80, y: 100, width: 200, height: 50))
            label.text = "Hello"
            label.backgroundColor = .systemBlue.withAlphaComponent(0.2)
            view.addSubview(label)
        }
        
        do {
            let label = UILabel(frame: .init(x: 80, y: 200, width: 200, height: 50))
            label.text = "World"
            label.backgroundColor = .systemBlue.withAlphaComponent(0.2)
            
            view.addSubview(label)
        }
        
        do {
            let button = UIButton(frame: .init(x: 80, y: 300, width: 200, height: 100))
            button.backgroundColor = .systemTeal
            button.setTitle("Button", for: .normal)
            button.accessibilityHint = "Button Touch"
            view.addSubview(button)
        }
        
        do {
            let view = UIView(frame: .init(x: 80, y: 450, width: 200, height: 100))
            view.backgroundColor = .systemBlue
            view.isAccessibilityElement = true
            view.accessibilityLabel = "Empty View"
            view.accessibilityValue = "123"
            self.view.addSubview(view)
        }
    }
}

struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            ViewController()
        }
        .printA11y()
    }
}
