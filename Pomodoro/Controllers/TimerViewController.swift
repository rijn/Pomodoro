//
//  TimerViewController.swift
//  Pomodoro
//
//  Created by Rijn on 7/29/18.
//  Copyright © 2018 Rijn. All rights reserved.
//

import Foundation
import DynamicColor
import SwiftIconFont

class TimerViewController: UIViewController {
    var scaleView: UIView?
    var widthPerSecond: CGFloat = 0
    
    var indicatorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.icon(from: .Ionicon, ofSize: 50.0)
        label.text = String.fontIonIcon("android-arrow-dropup")
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.PresetColors.Red
        
        view.addSubview(indicatorLabel)
    }
    
    override func viewDidLayoutSubviews() {
        widthPerSecond = self.view.frame.width / 9 / 60;
        
        scaleView?.removeFromSuperview()
        scaleView = ScaleView(frame: self.view.frame, gridScale: 1 / 9)
        scaleView?.backgroundColor = .clear
        view.addSubview(scaleView!)
        
        indicatorLabel.frame = CGRect(x: 0,
                                      y: view.frame.height / 2,
                                      width: view.frame.width,
                                      height: 50.0)
    }
    
    func setTime(second: Int) {
        scaleView?.center = CGPoint(x: CGFloat(30 * 60 - second) * widthPerSecond, y: scaleView!.center.y)
    }
}
