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
import ViewAnimator

class TimerViewController: UIViewController {
    var scaleView: UIView?
    var widthPerSecond: CGFloat = 0
    
    var currentTime: Int = 0
    
    var indicatorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.icon(from: .Ionicon, ofSize: 50.0)
        label.text = String.fontIonIcon("android-arrow-dropup")
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    var timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30);
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.PresetColors.Green
        
        view.addSubview(indicatorLabel)
        view.addSubview(timerLabel)
    }
    
    override func viewDidLayoutSubviews() {
        widthPerSecond = self.view.frame.width / 9 / 60;
        
        if (scaleView == nil) {
            scaleView?.removeFromSuperview()
            scaleView = ScaleView(frame: self.view.frame, gridScale: 1 / 9)
            scaleView?.backgroundColor = .clear
            view.addSubview(scaleView!)
        }
        
        indicatorLabel.frame = CGRect(x: 0,
                                      y: view.frame.height / 2,
                                      width: view.frame.width,
                                      height: 50.0)
        
        timerLabel.frame = CGRect(x: 0,
                                  y: view.frame.height / 4 * 3,
                                  width: view.frame.width,
                                  height: 50.0)
        
        scaleView?.center = CGPoint(x: CGFloat(30 * 60 - currentTime) * widthPerSecond,
                                    y: scaleView!.center.y)
        
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = self.currentTime == 0 ? UIColor.PresetColors.Green : UIColor.PresetColors.Red
        }
    }
    
    func setTime(second: Int) {
        currentTime = second
        timerLabel.text = String(format: "%02d:%02d", currentTime / 60, currentTime % 60)
        self.view.setNeedsLayout()
    }
}
