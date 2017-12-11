//
//  CoreMotionManager.swift
//  Motion_Demo
//
//  Created by Kinglin on 2017/11/21.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit
import CoreMotion

class MotionInfoModel: NSObject {
    
    var stepCount: Double?
    var distance: Double?
    var motionTime: TimeInterval?
    var currentPace: Double?
    var currentCadence: Double?
    var activeEnergy: Double?
    var averagePace: String?
    
    required override init(){}
}

class CoreMotionManager: NSObject {
    
    static let defaultManager: CoreMotionManager = CoreMotionManager()
    private override init() {
        super.init()
    }
    
    var pedometer: CMPedometer?
    var startDate: Date?
    
    // 获取当天一整天的运动步数和距离
    func getTodayMotionData(_ completion: @escaping (_ stepCount: Double, _ distance: Double, _ error:Error?) -> Void) {
        
        if !CMPedometer.isStepCountingAvailable() || !CMPedometer.isDistanceAvailable() {
            print("记步或距测不可用")
            return
        }
        if self.pedometer == nil {
            self.pedometer = CMPedometer()
        }
        
        let fromDate = Calendar.current.startOfDay(for: Date())
        let toDate = Date()
        self.pedometer?.queryPedometerData(from: fromDate, to: toDate, withHandler: { (pedometerData, queryError) in
            
            let stepCount = pedometerData?.numberOfSteps.doubleValue
            let distance = (pedometerData?.distance?.doubleValue)! / 1000.0
            
            if queryError != nil {
                completion(0, 0, queryError!)
                
            } else {
                completion(stepCount!, distance, nil)
            }
        })
    }
    
    // 开始运动计时
    func startMotion(_ completion: @escaping (_ motionInfo: MotionInfoModel?, _ error: Error?) -> Void) {
        if !CMPedometer.isStepCountingAvailable() || !CMPedometer.isDistanceAvailable() {
            print("记步或距测不可用")
            return
        }
        if self.pedometer == nil {
            self.pedometer = CMPedometer()
        }
        
        if self.startDate == nil {
            self.startDate = Date()
        }
        self.pedometer?.startUpdates(from: self.startDate!, withHandler: { (pedometerData, updateError) in
            print(pedometerData!)
            
            if updateError != nil {
                completion(nil, updateError)
                
            } else {
                let stepCount = pedometerData?.numberOfSteps.doubleValue            // 步数
                let distance = (pedometerData?.distance?.doubleValue)! / 1000.0     // 距离(公里)
                let motionTime = pedometerData?.endDate.timeIntervalSince((pedometerData?.startDate)!) // 运动时间
                let currentPace = pedometerData?.currentPace?.doubleValue           // 当前速度 s/m
                let currentCadence = pedometerData?.currentCadence?.doubleValue     // 当前速度 步/s
                let activeEnergy = ActiveEnergyBurned(distance)
                
                let model = MotionInfoModel()
                model.stepCount = stepCount
                model.distance = distance
                model.motionTime = motionTime
                model.currentPace = currentPace
                model.currentCadence = currentCadence
                model.activeEnergy = activeEnergy
                
                if #available(iOS 10.0, *) {
                    let averagePace = (pedometerData?.averageActivePace?.doubleValue)! * 1000.0 // 平均速度 s/km
                    let minutePace = String(format: "%02d\'%02d\"", Int(averagePace) / 60, Int(averagePace) % 60)  // 分钟/公里
                    model.averagePace = minutePace
                    
                } else {
                    let averagePace = Double(motionTime!) / distance
                    let minutePace = String(format: "%02d\'%02d\"", Int(averagePace) / 60, Int(averagePace) % 60)  // 分钟/公里
                    model.averagePace = minutePace
                }
                completion(model, nil)
            }
        })
    }
    
    // 暂停运动
    func pauseMotion() {
        
        guard self.pedometer != nil  else {
            return
        }
        self.pedometer?.stopUpdates()
    }
    
    // 停止运动
    func stopMotion() {
        self.pauseMotion()
        self.pedometer = nil
        self.startDate = nil
    }
    
}
