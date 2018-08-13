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
import AudioToolbox

class MainViewController: UIViewController {
    
    var currentTime: TimeInterval = NSDate().timeIntervalSince1970
    var targetTime: TimeInterval = 0
    var offsetTime: TimeInterval = 0
    var isPanning: Bool = false
    var timer: Timer? = nil
    let generator = UIImpactFeedbackGenerator(style: .light)
    
    var iCloudKeyStore: NSUbiquitousKeyValueStore? = NSUbiquitousKeyValueStore()
    let iCloudSavedTargetTimeKey = "TargetTimestamp"
    
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
        gestureRecognizer.maximumNumberOfTouches = 1
        view.addGestureRecognizer(gestureRecognizer)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        iCloudSetUp()
    }
    
    @objc func panGestureHandler(_ recognizer: UIPanGestureRecognizer) {
        let previousTargetInterval = targetTime + offsetTime - currentTime
        offsetTime = -TimeInterval(recognizer.translation(in: self.view).x)
        let targetInterval = targetTime + offsetTime - currentTime
        if targetInterval >= Double((floor(previousTargetInterval / 60) + 1) * 60) || previousTargetInterval >= Double((floor(targetInterval / 60) + 1) * 60){
            generator.impactOccurred()
        }
        
        switch recognizer.state {
        case .began:
            isPanning = true
            break
        case .changed:
            break
        case.ended:
            isPanning = false
            targetTime = targetTime + offsetTime
            offsetTime = 0
            saveTimerToiCloud()
            break
        default:
            break
        }
        
        if targetInterval  < 0 {
            targetTime = currentTime - offsetTime
        }
        if targetInterval > 3600 {
            targetTime = 3600 + currentTime - offsetTime
        }
        updateTimerView()
    }
    
    @objc func timerAction() {
        currentTime = NSDate().timeIntervalSince1970
        if targetTime < currentTime {
            targetTime = currentTime
        }
        updateTimerView()
    }
    
    func updateTimerView() {
        timerViewController.setTime(second: Int(targetTime + offsetTime - currentTime));
    }
    
    func saveTimerToiCloud() {
        iCloudKeyStore?.set(Double(targetTime), forKey: iCloudSavedTargetTimeKey)
        iCloudKeyStore?.synchronize()
    }
    
    func iCloudSetUp() {
        if let savedTargetTime = iCloudKeyStore?.double(forKey: iCloudSavedTargetTimeKey) {
            targetTime = savedTargetTime
        }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ubiquitousKeyValueStoreDidChangeExternally),
                                               name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
                                               object: iCloudKeyStore)
    }
    
    @objc func ubiquitousKeyValueStoreDidChangeExternally() {
        targetTime = iCloudKeyStore!.double(forKey: iCloudSavedTargetTimeKey)
    }
}
