//
//  MainViewController.swift
//  Pomodoro
//
//  Created by Rijn on 7/29/18.
//  Copyright © 2018 Rijn. All rights reserved.
//

import Foundation
import UIKit
import TinyConstraints

class MainViewController: UIViewController {
    
    var timerViewController: TimerViewController = {
        let timerViewController = TimerViewController()
        timerViewController.view.layer.cornerRadius = 20
        timerViewController.view.layer.masksToBounds = false
        timerViewController.view.clipsToBounds = true
        return timerViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let size = min(self.view.frame.width, self.view.frame.height) * 0.7
        view.addSubview(timerViewController.view)
        timerViewController.view.width(size)
        timerViewController.view.height(size)
        timerViewController.view.center(in: self.view)
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandler(_:)))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func panGestureHandler(_ recognizer: UIPanGestureRecognizer) {
        timerViewController.setTime(second: 600)
        print(recognizer)
    }
}
