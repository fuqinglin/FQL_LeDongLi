//
//  QLRunningViewController.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/27.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit
import MapKit

class QLRunningViewController: QLBaseViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapDistanceLabel: UILabel!
    @IBOutlet weak var mapTimeLabel: UILabel!
    
    @IBOutlet weak var runningView: UIView!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var runDistanceLabel: UILabel!
    @IBOutlet weak var runSpeedLabel: UILabel!
    @IBOutlet weak var runActiveEnergyLabel: UILabel!
  
    @IBOutlet weak var stopButton: LongPressButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resumeButtonCenterX: NSLayoutConstraint!
    @IBOutlet weak var stopButtonCenterX: NSLayoutConstraint!
    
    @IBOutlet weak var prepareView: UIView!
    @IBOutlet weak var prepareTimeLabel: UILabel!
    
    var totalSeconds: Int = 0  // 跑步总时间(s)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.prepareAnimation(3)
        self.stopButtonAction()
    }
    
    // MARK: - 跑步相关
    private func startRunning() {
        CoreMotionManager.defaultManager.startMotion { (motionInfo, error) in
            guard error == nil else {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.runDistanceLabel.text = String(format: "%.2f", (motionInfo?.distance)!)
                self.mapDistanceLabel.text = String(format: "%.2f", (motionInfo?.distance)!)
                self.runSpeedLabel.text = motionInfo?.averagePace
                self.runActiveEnergyLabel.text = String(format: "%.f",(motionInfo?.activeEnergy)!)
            }
        }
    }
    
    private func pauseRunning() {
        CoreMotionManager.defaultManager.pauseMotion()
    }
    
    private func stopRunning() {
        CoreMotionManager.defaultManager.stopMotion()
    }
    
    // MARK: - 跑步定时器
    lazy var timer: Timer = {
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(running), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
        return timer
    }()
    
    @objc private func running() {
        totalSeconds += 1
        self.runTimeLabel.text = self.timeFormate(totalSeconds)
        self.mapTimeLabel.text = self.runTimeLabel.text
    }
    
    private func startTimer() {
        self.timer.fireDate = Date(timeIntervalSinceNow: 1)
    }
    
    private func pauseTimer() {
        self.timer.fireDate = Date.distantFuture
    }
    
    private func resumeTimer() {
        self.timer.fireDate = Date.distantPast
    }
    
    private func stopTimer() {
        self.timer.invalidate()
    }
    
    private func timeFormate(_ seconds: Int) -> String {
        return String(format: "%02d:%02d:%02d", seconds / 3600, seconds / 60, seconds % 60 )
    }

    // MARK: - buttonActions
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.closeAnimation()
    }
    
    @IBAction func pauseButtonAction(_ sender: UIButton) {
        self.pauseAnimation()
        self.pauseTimer()
        self.pauseRunning()
    }
    
    @IBAction func resumeButtonAction(_ sender: UIButton) {
        self.resumeAnimation()
        self.resumeTimer()
        self.startRunning()
    }
    
    private func stopButtonAction() {
        
        self.stopButton.longPressCompletion = {(finish) in
            self.stopTimer()
            self.stopRunning()
            self.stopAnimation()
        }
    }
    
    @IBAction func locationButtonAction(_ sender: UIButton) {
        self.locationAnimation()
    }
    
    // MARK: - animations
    
    func prepareAnimation(_ second: Int) {
        
        if second < 0 {
            self.prepareView.removeFromSuperview()
            self.startTimer()
            self.startRunning()
            return
        } else if second == 0 {
            self.prepareTimeLabel.text = "GO"
            
        } else {
            self.prepareTimeLabel.text = "\(second)"
        }

        UIView.animate(withDuration: 1, animations: {
            self.prepareTimeLabel.transform = .init(scaleX: 2.0, y: 2.0)
            self.prepareTimeLabel.alpha = 0
            
        }) { (finish) in
            self.prepareTimeLabel.transform = .identity
            self.prepareTimeLabel.alpha = 1

            self.prepareAnimation(second-1)
        }
    }
    
    func pauseAnimation() {
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.stopButtonCenterX.constant = -100
            self.resumeButtonCenterX.constant = 100
            self.pauseButton.transform = .init(scaleX: 0, y: 0)
            self.runningView.layoutIfNeeded()
            
        }) { (finish) in
            
        }
    }
    
    func resumeAnimation() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.stopButtonCenterX.constant = 0
            self.resumeButtonCenterX.constant = 0
            self.pauseButton.transform = .identity
            self.runningView.layoutIfNeeded()
            
        }) { (finish) in
            
        }
    }
    
    func stopAnimation() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func locationAnimation() {
        UIView.animate(withDuration: 0.5, animations: {
            self.runningView.transform = .init(translationX: 0, y: SCREEN_HEIGHT)
            self.view.layoutIfNeeded()
            
        }) { (finish) in
            
        }
    }
    
    func closeAnimation() {
        UIView.animate(withDuration: 0.5, animations: {
            self.runningView.transform = .identity
            self.view.layoutIfNeeded()
            
        }) { (finish) in
            
        }
    }
 
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
