//
//  QLMyInfoViewController.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/9.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit

class QLMyInfoViewController: QLBaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userImageView: UIView!
    @IBOutlet weak var nikeNameLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var itemsSupView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSubViews()
    }
    
    private func setSubViews() {

        for view in self.itemsSupView.subviews {
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.white.cgColor
        }
    }

    @IBAction func closeButtonAction(_ sender: UIButton) {
        
       self.view.snp.updateConstraints({ (make) in
            make.top.equalTo(-SCREEN_HEIGHT)
        })
        UIView.animate(withDuration: 1) {
            UIApplication.shared.keyWindow?.layoutIfNeeded()
        }
    }
    
    @IBAction func shareButtonAction(_ sender: UIButton) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension QLMyInfoViewController: UIScrollViewDelegate {
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return true
    }
}


