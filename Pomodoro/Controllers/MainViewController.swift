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
    
    var timerViewController: UIViewController = {
        let timerViewController = TimerViewController()
        timerViewController.view.layer.cornerRadius = 20
        timerViewController.view.clipsToBounds = true
        return timerViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(timerViewController.view)
        timerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        timerViewController.view.width(to: self.view, nil, multiplier: 0.7, offset: 0, relation: .equal, priority: .defaultLow, isActive: true)
        timerViewController.view.height(to: self.view, nil, multiplier: 0.7, offset: 0, relation: .equal, priority: .defaultLow, isActive: true)
        timerViewController.view.heightAnchor.constraint(equalTo: timerViewController.view.widthAnchor, multiplier: 1).isActive = true
        timerViewController.view.center(in: self.view)
    }
    
}
