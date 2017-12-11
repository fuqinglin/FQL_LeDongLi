//
//  QLRunningDataCell.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/7.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit

protocol RunningDataCellDalegate {
    
    // 运动训练
    func sportsTraining()
    
    // 跑步记录
    func runningRecord()
}

class QLRunningDataCell: UICollectionViewCell {

    @IBOutlet weak var circularView: QLMotionCircularView!
    @IBOutlet weak var stepNumberLabel: UILabel!
    @IBOutlet weak var pathNumberLabel: UILabel!
    @IBOutlet weak var calorieNumberLabel: UILabel!
    @IBOutlet weak var timeNumberLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    let maxStepCount: Double = 10000.0
    var delegate: RunningDataCellDalegate?
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        if sender.tag == 1 {
            self.delegate?.sportsTraining()
            
        } else {
            self.delegate?.runningRecord()
        }
    }
    
    func refreshMotionValues() {
        CoreMotionManager.defaultManager.getTodayMotionData { (stepCount, distance, error) in
            
            DispatchQueue.main.async {
                self.stepNumberLabel.text = String(format: "%.f", stepCount)
                self.pathNumberLabel.text = String(format: "%.1f", distance)
                self.circularView.startAnimation(CGFloat(stepCount / self.maxStepCount))
                self.circularView.refreshPercent(CGFloat(stepCount / self.maxStepCount))
            }
        }
        
        HealthKitManager.defaultManager.getActiveEnergyAndTime { (energy, time, error) in
            
            DispatchQueue.main.async {
                self.calorieNumberLabel.text = String(format: "%.f", energy)
                self.timeNumberLabel.text = String(format: "%.f", time)
            }
        }
    }
    
    var weatherModel: Weather? {
        didSet {
            guard let model = weatherModel else {
                return
            }
            self.weatherLabel.text = "\(model.min_temperature!)℃ - \(model.max_temperature!)℃ 空气 \(model.quality!)"
            self .refreshMotionValues()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
