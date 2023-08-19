import UIKit

extension UIView {
    func printA11y(border: Bool = true) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self else { return }
            exposedAccessibleViews
                .enumerated()
                .forEach { index, view in
                    view.attachBagde(index: index + 1, border: border)
                }
            print(axSnapshot())
        }
    }
}

private extension UIView {
    func attachBagde(index: Int, border: Bool) {
        let label = BadgeLabelBuilder().build(index: index)
        guard
            let window = UIApplication.shared.windows.first(where: \.isKeyWindow),
            border
        else {
            addSubview(label)
            return
        }
        
        lazy var bgColors: [UIColor] = [
            .systemRed, .systemGreen, .systemOrange, .systemYellow, .systemPink, .systemTeal, .systemIndigo, .systemBrown,
        ]
        
        let frame = convert(frame, from: window)
        let color = bgColors[index % bgColors.count]
        let borderView = makeBorderView(frame: frame, borderColor: color)
        window.addSubview(borderView)
        label.center = .zero
        borderView.addSubview(label)
    }
    
    private func makeBorderView(frame: CGRect, borderColor: UIColor) -> UIView {
        let borderView = UIView(frame: frame)
        borderView.accessibilityTraits = .none
        borderView.backgroundColor = .clear
        borderView.isUserInteractionEnabled = false
        borderView.isAccessibilityElement = false
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = borderColor.cgColor
        return borderView
    }
}
