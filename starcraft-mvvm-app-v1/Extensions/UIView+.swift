//
//  UIView+.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 10/01/2023.
//

import UIKit

extension UIView {
    func applyBlurEffect(with style: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}
