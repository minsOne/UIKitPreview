import UIKit

struct BadgeLabelBuilder {
    init() {}
    func build(index: Int) -> UILabel {
        let bgColors: [UIColor] = [.systemRed, .systemGreen, .systemOrange, .systemYellow, .systemPink, .systemTeal, .systemIndigo, .systemBrown]
        let label = UILabel()
        label.text = "\(index)"
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.backgroundColor = bgColors[index%bgColors.count].withAlphaComponent(0.5)
        label.isUserInteractionEnabled = false
        label.accessibilityTraits = .none
        label.isAccessibilityElement = false
        label.textAlignment = .center
        label.sizeToFit()
        
        let size = label.bounds.size
        let max = max(size.width, size.height)
        label.frame.size = .init(width: max, height: max)

        label.layer.cornerRadius = max / 2
        label.layer.cornerCurve = .continuous
        label.layer.masksToBounds = true
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        
        return label
    }
}
