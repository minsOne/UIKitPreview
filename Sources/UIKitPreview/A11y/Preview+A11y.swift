import Foundation
import SwiftUI

public extension ViewPreview {
    func printA11y(border: Bool = true) -> Self {
        view.printA11y(border: border)
        return self
    }
}

public extension ViewControllerPreview {
    func printA11y(border: Bool = true) -> Self {
        viewController.view.printA11y(border: border)
        return self
    }
}

public extension NavigationControllerPreview {
    func printA11y(border: Bool = true) -> Self {
        navigationController.topViewController?.view.printA11y(border: border)
        return self
    }
}
