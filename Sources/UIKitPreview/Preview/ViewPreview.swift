//
//  ViewPreview.swift
//  PreviewView
//
//  Created by Josh Asbury on 7/8/21.
//

import SwiftUI

/// A type that can be used to preview in Xcode a `UIView`.
///
/// ```swift
/// struct YourView_Previews: PreviewProvider {
///     static var previews: some View {
///         ViewPreview {
///             YourView()
///         }
///         .previewLayout(.fixed(width: 375, height: 86))
///     }
/// }
/// ```
///
/// - Important: For the best possible previewing of a standalone view, you should set the `.previewLayout` values to be the expected in-app sizes of your view.
/// - SeeAlso: ``ViewControllerPreview``
public struct ViewPreview<View: UIView>: UIViewRepresentable {
    let view: View
    
    init(_ builder: @escaping () -> View) {
        view = builder()
    }
    
    // MARK: - UIViewRepresentable
    
    public func makeUIView(context: Context) -> UIView { view }
    
    public func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
