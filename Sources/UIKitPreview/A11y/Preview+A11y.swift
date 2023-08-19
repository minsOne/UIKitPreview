import Foundation
import SwiftUI

public extension ViewPreview {
    func printA11y(border: Bool = true) -> some SwiftUI.View {
        onAppear {
            view.printA11y(border: border)
        }
    }
}

public extension ViewControllerPreview {
    func printA11y(border: Bool = true) -> some View {
        onAppear {
            viewController.view.printA11y(border: border)
        }
    }
}

public extension NavigationControllerPreview {
    func printA11y(border: Bool = true) -> some View {
        onAppear {
            navigationController.topViewController?.view.printA11y(border: border)
        }
    }
}
