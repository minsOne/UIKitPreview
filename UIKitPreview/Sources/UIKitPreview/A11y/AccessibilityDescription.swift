//
//  AccessibilityDescription.swift
//
//
//  Created by Sungdoo on 2022/03/12.
//

import Foundation
import UIKit

/// generateAccessibilityDescription for Single accessibleElement
///
/// Replace this closure to generate your custom snapshot format
public var generateAccessibilityDescription: (NSObject) -> String = { object in

    let list = [
        generateAccessbilityLabelDescription(object),
        generateAccessibilityValueDescription(object),
        generateAccessibilityTraitDescription(object),
        generateAccessibilityHintDescription(object),
        generateAccessibilityCustomActionsDescription(object),
    ]
    
    return list.filter(\.isNotEmpty).joined(separator: "\n")
}

public var generateAccessbilityLabelDescription: (NSObject) -> String = { object in
    var description = ""

    if let label = object.accessibilityLabel, label.isNotEmpty {
        description = label
    } else if let labelText = (object as? UILabel)?.text, labelText.isNotEmpty {
        description = labelText
    } else if let buttonText = (object as? UIButton)?.titleLabel?.text, buttonText.isNotEmpty {
        description = buttonText
    } else if let activityIndicator = object as? UIActivityIndicatorView {
        description = "Activity Indicator"
    } else if let stepper = object as? UIStepper {
        description = "Stepper"
    } else if let segmentedControl = object as? UISegmentedControl {
        description = "SegmentedControl with \(segmentedControl.numberOfSegments) segments"
    }

    if description.isNotEmpty {
        return "│ [Label] \(description)"
    } else {
        return ""
    }
}

public var generateAccessibilityValueDescription: (NSObject) -> String = { object in
    var description = ""

    if let value = object.accessibilityValue, value.isNotEmpty {
        description = value
    } else if let progressView = object as? UIProgressView {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        let progress = numberFormatter.string(for: progressView.progress) ?? ""
        description = progress
    } else if let slider = object as? UISlider {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        let percentage = numberFormatter.string(for: slider.value / (slider.maximumValue - slider.minimumValue)) ?? ""
        description = "Absolute: \(slider.value), Percentage: \(percentage)"
    } else if let textField = object as? UITextField {
        description = textField.text ?? ""
    } else if let textView = object as? UITextView {
        description = textView.text ?? ""
    } else if let activityIndicator = object as? UIActivityIndicatorView {
        description = activityIndicator.isAnimating ? "Animating" : "Halted"
    } else if let uiSwitch = object as? UISwitch {
        description = uiSwitch.isOn ? "1" : "0"
    } else if let segmentedControl = object as? UISegmentedControl {
        if segmentedControl.selectedSegmentIndex >= 0 {
            let selectedSegmentTitle = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex) ?? ""
            description = "Selected: \(selectedSegmentTitle)"
        } else {
            description = "Selected: None"
        }
    }

    if description.isNotEmpty {
        return "│ [Value] \(description)"
    } else {
        return ""
    }
}

public var generateAccessibilityTraitDescription: (NSObject) -> String = { object in
    var description = ""

    switch object {
    case _ where object.accessibilityTraits.isEmpty == false && object.accessibilityTraits.isStandardTraits:
        description = "\(object.accessibilityTraits.descripion)"
    case is UIButton,
         is UISwitch:
        description = "\(UIAccessibilityTraits.button.descripion)"
    case is UISlider:
        description = "\(UIAccessibilityTraits.adjustable.descripion)"
    case is UITextView:
        description = "TextView"
    case is UITextField:
        description = "TextField"
    default:
        break
    }

    if description.isNotEmpty {
        return "│ [Trait] \(description)"
    } else {
        return ""
    }
}

public var generateAccessibilityHintDescription: (NSObject) -> String = { object in
    var description = ""
    if let hint = object.accessibilityHint {
        description = "│ [Hint] \(hint)"
    }
    return description
}

public var generateAccessibilityCustomActionsDescription: (NSObject) -> String = { object in
    var description = ""
    if let actions = object.accessibilityCustomActions,
       actions.isNotEmpty
    {
        description += actions.map(\.name).joined(separator: ", ")
    }

    if description.isNotEmpty {
        return "│ [Actions] \(description)"
    } else {
        return ""
    }
}

extension NSObject {
    var accessibilityDescription: String {
        generateAccessibilityDescription(self)
    }
}
