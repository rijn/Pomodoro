//
//  TimerViewController.swift
//  Pomodoro
//
//  Created by Rijn on 7/29/18.
//  Copyright © 2018 Rijn. All rights reserved.
//

import Foundation
import DynamicColor

class TimerViewController: UIViewController {
    var scaleView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.PresetColors.Red
    }
    
    override func viewDidLayoutSubviews() {
        scaleView?.removeFromSuperview()
        scaleView = ScaleView(frame: self.view.frame, gridScale: 1 / 9)
        scaleView?.backgroundColor = .clear
        view.addSubview(scaleView!)
    }
}
