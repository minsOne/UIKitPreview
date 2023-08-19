//
//  UIResponder+Extension.swift
//
//
//  Created by Sungdoo on 2022/03/12.
//

import Foundation
import UIKit

extension UIResponder {
    @objc
    var isExposedToAssistiveTech: Bool {
        guard
            shouldForceExposeToAssistiveTech || isAccessibilityElement
        else { return false }

        let hasExposedToAssistiveTech = allItemsInResponderChain.contains(where: \.isExposedToAssistiveTech)
        return !hasExposedToAssistiveTech
    }

    private var hasBlockingElementInResponderChain: Bool {
        allItemsInResponderChain.contains(where: { item in
            item.isExposedToAssistiveTech || (item as? UIView)?.isHidden == true
        })
    }

    /// A boolean value indicates that the elment is exposed to AssistiveTechnology
    /// even if `isAccessibilityElement` is false
    ///
    /// Standard UIKit Controlst are not exposed to AssistiveTechnology when its `hidden` value is true
    /// - Date: 2022. 04. 02
    var shouldForceExposeToAssistiveTech: Bool {
        guard let view = self as? UIView else { return false }
        return view.isStandardUIKitControl && view.isHidden == false
    }

    /// A boolean value indicates that the elment is standard UIKit Control
    ///
    /// Standard UIKit Controlst are exposed to AssistiveTechnology even if  value of`isAccessibilityElement` is false
    /// - Date: 2022. 04. 02
    var isStandardUIKitControl: Bool {
        switch self {
            case is UIProgressView,
                 is UILabel,
                 is UIButton,
                 is UISlider,
                 is UISwitch,
                 is UITextView,
                 is UIActivityIndicatorView,
                 is UIStepper,
                 is UISegmentedControl,
                 is UITextField:
                return true
            default:
                return false
        }
    }

    var allItemsInResponderChain: [UIResponder] {
        var chain = [UIResponder]()
        var nextResponder = next
        while nextResponder != nil {
            chain.append(nextResponder!)
            nextResponder = nextResponder?.next
        }
        return chain
    }
}

extension UIView {
    @objc override var isExposedToAssistiveTech: Bool {
        if isHidden {
            return false
        }

        if allItemsInResponderChain.compactMap({ $0 as? UIView }).contains(where: { $0.isHidden }) {
            return false
        }

        return super.isExposedToAssistiveTech
    }
}
