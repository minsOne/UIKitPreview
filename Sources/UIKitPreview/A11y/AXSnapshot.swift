import UIKit

public extension UIView {
    /// Generate text-formatted snapshot of accessibility experience
    func axSnapshot() -> String {
        guard
            case let descriptions = exposedAccessibleViews.map(\.accessibilityDescription),
            descriptions.isNotEmpty
        else { return "" }

        let seperator = "------------------------------------------------------------"
        var description = seperator + "\n"
        description += descriptions.joined(separator: "\n\(seperator)\n")
        description += "\n\(seperator)"
        return description
    }

    /// List of all subviews that are accessible via assistive technology such as VoiceOver
    var exposedAccessibleViews: [UIView] {
        ([self] + allSubviews)
            .filter(\.isExposedToAssistiveTech)
    }
}

public extension UIViewController {
    /// Generate text-formatted snapshot of accessibility experience
    func axSnapshot() -> String {
        view.axSnapshot()
    }
}

extension UIView {
    /// List of all subviews in view tree
    var allSubviews: [UIView] {
        subviews.flatMap { [$0] + $0.allSubviews }
    }
}
