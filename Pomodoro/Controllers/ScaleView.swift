//
//  ScaleView.swift
//  Pomodoro
//
//  Created by Rijn on 7/29/18.
//  Copyright © 2018 Rijn. All rights reserved.
//

import Foundation
import UIKit

class ScaleView : UIView {
    var gridScale: CGFloat?
    var size: CGFloat?
    
    init(frame: CGRect, gridScale: CGFloat) {
        super.init(frame: CGRect(x: 0,
                                 y: 0,
                                 width: frame.width * gridScale * 60,
                                 height: frame.height))
        self.gridScale = gridScale
        self.size = frame.height
    }
    
    convenience init() {
        self.init(frame: CGRect.zero, gridScale: 0)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.white.setFill()
        print(rect, size!)
        var x: CGFloat = size! / 2
        let y: CGFloat = size! / 2 - size! * LayoutConstraints.paddingBetweenScaleAndLineFactor
        let diffX = size! * gridScale!
        let largeScaleWidth = size! * LayoutConstraints.largeScaleWidthFactor
        let largeScaleHeight = size! * LayoutConstraints.largeScaleHeightFactor
        let smallScaleWidth = size! * LayoutConstraints.smallScaleWidthFactor
        let smallScaleHeight = size! * LayoutConstraints.smallScaleHeightFactor
        let fontHeight = largeScaleHeight + size! * LayoutConstraints.paddingBetweenScaleAndLineFactor / 2 + size! / 10
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        for i in 0...60 {
            let scaleWidth = i % 5 == 0 ? largeScaleWidth : smallScaleWidth
            let scaleHeight = i % 5 == 0 ? largeScaleHeight : smallScaleHeight
            let rect = UIBezierPath(rect: CGRect(x: x - scaleWidth / 2,
                                                 y: y - scaleHeight,
                                                 width: scaleWidth,
                                                 height: scaleHeight))
            rect.fill()
            if i % 5 == 0 {
                let string = NSString(format: "%d", i)
                string.draw(in: CGRect(x: x - diffX * 2, y: y - fontHeight, width: diffX * 4, height: fontHeight),
                            withAttributes: [
                                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: size! / 10),
                                NSAttributedStringKey.paragraphStyle: paragraphStyle,
                                NSAttributedStringKey.foregroundColor: UIColor.white,])
            }
            x += diffX
        }
    }
}
