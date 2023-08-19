//
//  ViewControllerPreview.swift
//  PreviewView
//
//  Created by Josh Asbury on 7/8/21.
//

import SwiftUI
import UIKit

/// A type that can be used to preview in Xcode a `UIViewController`.
///
/// ```swift
/// struct YourViewController_Previews: PreviewProvider {
///     static var previews: some View {
///         ViewControllerPreview(YourViewController())
///     }
/// }
/// ```
public struct ViewControllerPreview: UIViewControllerRepresentable {
    let viewController: UIViewController

    public init(_ viewController: UIViewController) {
        self.viewController = viewController
    }

    public init(_ builder: @escaping () -> UIViewController) {
        self.viewController = builder()
    }

    public func makeUIViewController(context: Context) -> some UIViewController { viewController }
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

public extension UIViewController {
    var preview: ViewControllerPreview {
        ViewControllerPreview(self)
    }
}
