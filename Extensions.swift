//
//  Extensions.swift
//  Pomodoro
//
//  Created by Rijn on 7/29/18.
//  Copyright © 2018 Rijn. All rights reserved.
//

import Foundation
import UIKit
import DynamicColor

extension UIColor {
    struct PresetColors {
        static let Grey = UIColor(hue: 0, saturation: 0, brightness: 0.7, alpha: 1)
        static let DarkGrey = UIColor(hue: 0, saturation: 0, brightness: 0.5, alpha: 1)
        static let LightGrey = UIColor(hue: 0, saturation: 0, brightness: 0.85, alpha: 1)
        static let Red = DynamicColor(hex: 0xf40c05)
        static let Green = DynamicColor(hex: 0x18c93b)
    }
}

struct LayoutConstraints {
    static let largeScaleWidthFactor: CGFloat = 0.03;
    static let largeScaleHeightFactor: CGFloat = 0.15;
    static let smallScaleWidthFactor: CGFloat = 0.01;
    static let smallScaleHeightFactor: CGFloat = 0.1;
    static let paddingBetweenScaleAndLineFactor: CGFloat = 0.1;
}

extension UINavigationController {
    func pushViewControllerFromBottom(_ viewController: UIViewController) {
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromBottom
        self.view.layer.add(transition, forKey: kCATransition)
        self.pushViewController(viewController, animated: false)
    }
}

public enum Fonts: String {
    case fontAwesome = "FontAwesome"
    case iconic = "open-iconic"
    case ionicon = "Ionicons"
    case octicon = "octicons"
    case themify = "themify"
    case mapIcon = "map-icons"
    case materialIcon = "MaterialIcons-Regular"
}
