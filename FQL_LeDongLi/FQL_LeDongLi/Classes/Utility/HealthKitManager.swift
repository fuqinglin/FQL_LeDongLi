//
//  HealthKitManager.swift
//  Motion_Demo
//
//  Created by Kinglin on 2017/11/21.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit
import HealthKit

let WEIGHT = 50.0 // 体重
let K = 1.036   // 消耗能量的系数

class HealthKitManager: NSObject {
    
    var healthStore: HKHealthStore?
    
    static let defaultManager: HealthKitManager = HealthKitManager()
    private override init() {
        super .init()
    }
    
    // 授权
    func authorizeHealthKit(_ completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        
        if #available(iOS 8.0, *) {
            
            // 判断设备的健康数据是否可用
            if !HKHealthStore.isHealthDataAvailable() {
                let error = NSError(domain: "", code: 2, userInfo: ["error": "设备的健康数据不可用"])
                completion(false, error)
                return 
            }
            
            if self.healthStore == nil {
                self.healthStore = HKHealthStore()
            }
            
            // 请求授权可读写的数据
            let readTypes = self.readDataTypes()
            let writeTypes = self.writeDataTypes()
            self.healthStore?.requestAuthorization(toShare: writeTypes, read: readTypes, completion: { (success, error) in
                
                if success {
                    completion(true, nil)
                    
                } else {
                    completion(false, error)
                }
            })
            
        } else {
            print("系统版本过低不能使用Health数据")
        }
    }
    
    // 设置可读取的数据
    private func readDataTypes() -> Set<HKObjectType>? {
        
        let heightType = HKObjectType.quantityType(forIdentifier: .height)
        let weightType = HKObjectType.quantityType(forIdentifier: .bodyMass)
        let tempertureType = HKObjectType.quantityType(forIdentifier: .bodyTemperature)
        let birthType = HKObjectType.characteristicType(forIdentifier: .dateOfBirth)
        let sexType = HKObjectType.characteristicType(forIdentifier: .biologicalSex)
        let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount)
        let distanceType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)
        let activeEnergyType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)
        let basalEnergyType = HKObjectType.quantityType(forIdentifier: .basalEnergyBurned)
        
        return [heightType!, weightType!, tempertureType!, birthType!, sexType!, stepCountType!, distanceType!, activeEnergyType!, basalEnergyType!]
    }
    
    // 设置可写入的数据
    private func writeDataTypes() -> Set<HKSampleType>? {
        
        let heightType = HKSampleType.quantityType(forIdentifier: .height)
        let weightType = HKSampleType.quantityType(forIdentifier: .bodyMass)
        let energyType = HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)
        
        return [heightType!, weightType!,energyType!]
    }
    
    // 查询条件谓词
    func predicateForToday() -> NSPredicate? {
        // 当天0点
        let startDate = Calendar.current.startOfDay(for: Date())
        // 当天结束
        let endDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        // 查询条件
        return HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
    }
    
    // 获取步数
    func getStepCount(_ completion: @escaping (_ stepCount: Double, _ error: Error?) -> Void) {
        
        self.authorizeHealthKit { (success, error) in
            guard error == nil else {
                print(error!)
                return
            }
            // 设置查询类型、查询条件、排序方式
            let sampleType = HKSampleType.quantityType(forIdentifier: .stepCount)!
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
            let predicate = self.predicateForToday()
            
            // 创建查询
            let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { (sampleQuery, samples, error) in
                
                if error != nil {
                    completion(0, error!)
                    
                } else {
                    
                    var totalStepCount: Double = 0
                    for sample in samples! {
                        let quantitySample = sample as! HKQuantitySample
                        let quantity = quantitySample.quantity
                        let unit = HKUnit.count()
                        let step = quantity.doubleValue(for: unit)
                        totalStepCount += step
                    }
                    completion(totalStepCount, nil)
                }
            }
            
            // 执行查询
            self.healthStore?.execute(query)
        }
    }
    
    // 获取步行+跑步的距离
    func getDistance(_ completion: @escaping (_ distance: Double, _ error: Error?) -> Void) {
        
        self.authorizeHealthKit { (success, error) in
            guard error == nil else {
                print(error!)
                return
            }
            let sampleType = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)!
            let sortDesriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)
            let predicate = self.predicateForToday()
            
            let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDesriptor]) { (sampleQuery, samples, error) in
                
                if error != nil {
                    completion(0, error!)
                    
                } else {
                    
                    var totalDistance: Double = 0
                    for sample in samples! {
                        let quantitySample = sample as! HKQuantitySample
                        let quantity = quantitySample.quantity
                        let unit = HKUnit.meterUnit(with: .kilo)
                        let distance = quantity.doubleValue(for: unit)
                        totalDistance += distance
                    }
                    completion(totalDistance, nil)
                }
            }
            self.healthStore?.execute(query)
        }
    }
    
    // 获取消耗的卡路里和运动时间
    func getActiveEnergyAndTime(_ completion: @escaping (_ calorie: Double, _ totalTime: TimeInterval, _ error: Error?) -> Void) {
        
        self.authorizeHealthKit { (success, error) in
            guard error == nil else {
                print(error!)
                return
            }
            
            let sampleType = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)!
            let sortDesriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)
            let predicate = self.predicateForToday()
            
            let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDesriptor]) { (sampleQuery, samples, error) in
                
                if error != nil {
                    completion(0, 0, error!)
                    
                } else {
                    
                    var totalDistance: Double = 0
                    var totalTime: TimeInterval = 0
                    for sample in samples! {
                        let quantitySample = sample as! HKQuantitySample
                        let quantity = quantitySample.quantity
                        let unit = HKUnit.meterUnit(with: .kilo)
                        let distance = quantity.doubleValue(for: unit)
                        let time = quantitySample.endDate.timeIntervalSince(quantitySample.startDate)
                        totalDistance += distance
                        totalTime += time
                    }
                    let energy = totalDistance * WEIGHT * K  // 卡路里消耗计算公式：距离 * 体重 * 系数  (这个公式只是粗略计算)
                    completion(energy, totalTime / 60.0, nil)
                }
            }
            self.healthStore?.execute(query)
        }
    }

}






