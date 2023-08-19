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
    var description = generateAccessbilityLabelDescription(object)

    let accessibilityValueDescription = generateAccessibilityValueDescription(object)
    if accessibilityValueDescription.isNotEmpty, description.isNotEmpty {
        description += ", "
    }
    description += accessibilityValueDescription

    description += generateAccessibilityTraitDescription(object)
    description += generateAccessibilityHintDescription(object)
    description += generateAccessibilityCustomActionsDescription(object)

    return description
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
    return description
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
    return description
}

public var generateAccessibilityTraitDescription: (NSObject) -> String = { object in
    var description = ""

    switch object {
    case _ where object.accessibilityTraits.isEmpty == false && object.accessibilityTraits.isStandardTraits:
        description = "\n\(object.accessibilityTraits.descripion)"
    case is UIButton,
         is UISwitch:
        description = "\n\(UIAccessibilityTraits.button.descripion)"
    case is UISlider:
        description = "\n\(UIAccessibilityTraits.adjustable.descripion)"
    case is UITextView:
        description = "\nTextView"
    case is UITextField:
        description = "\nTextField"
    default:
        break
    }

    return description
}

public var generateAccessibilityHintDescription: (NSObject) -> String = { object in
    var description = ""
    if let hint = object.accessibilityHint {
        description = "\n\(hint)"
    }
    return description
}

public var generateAccessibilityCustomActionsDescription: (NSObject) -> String = { object in
    var description = ""
    if let actions = object.accessibilityCustomActions {
        description += "\n"
        description += "Actions: "
        description += actions.map(\.name).joined(separator: ", ")
    }
    return description
}

extension NSObject {
    var accessibilityDescription: String {
        generateAccessibilityDescription(self)
    }
}
