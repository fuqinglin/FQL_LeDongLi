//
//  QLHomeViewController.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/2.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit

let RunningDataCellID = "QLRunningDataCell"
let DietCellID = "QLDietCell"
let AdCellID = "QLAdCell"

class QLHomeViewController: QLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSubViews()
    }
    
    // MARK: - initSubViews
    
    private func initSubViews() {
        
        self.navigationItem.titleView = self.titleView
        self.title = "训练"
        
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-49)
        }
        
        let todayVC = QLTodayViewController()
        let planVC = QLPlanViewController()
        self.addChildViewController(todayVC)
        self.addChildViewController(planVC)
        
        self.scrollView.addSubview(todayVC.view)
        self.scrollView.addSubview(planVC.view)

        todayVC.view.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(SCREEN_HEIGHT-64-49)
            make.top.left.bottom.equalToSuperview()
        }
        
        planVC.view.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(SCREEN_HEIGHT-64-49)
            make.top.bottom.equalToSuperview()
            make.left.equalTo(todayVC.view.snp.right)
            make.right.equalTo(self.scrollView.snp.right)
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init()
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var titleView: QLSegment = {
        
        let view = QLSegment.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 150, height: 44))
        view.titles = ["今天", "计划"]
        view.delegate = self
        return view
    }()
}

extension QLHomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let index = scrollView.contentOffset.x / SCREEN_WIDTH
        self.titleView.scrollToIndex(index)
    }
}

extension QLHomeViewController: QLSegmentDelegate {

    func scrollToSelectedIndex(index: Int) {

        let rect = CGRect(x: CGFloat(index) * SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: self.scrollView.bounds.size.height)
        self.scrollView.scrollRectToVisible(rect, animated: true)
    }
}







