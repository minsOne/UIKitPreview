import UIKit

public extension UIView {
    /// Generate text-formatted snapshot of accessibility experience
    func axSnapshot() -> String {
        guard
            case let descriptions = exposedAccessibleViews.map(\.accessibilityDescription),
            descriptions.isNotEmpty
        else { return "" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        var description = "┌────── 🗣️ Voice Over ─────────"
        description += "\n│ LogTime : \(dateFormatter.string(from: Date()))"
        descriptions.enumerated().forEach { index, desc in
            description += "\n│ 🗣️ \(index+1)번째 접근성 요소\n\(desc)"
        }
        description += "\n└─────────────────────────────\n"
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
