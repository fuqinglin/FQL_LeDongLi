//
//  QLTabBarController.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/2.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit

class QLTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setTabBar()
    }
    
    private func setTabBar() {
        
        let selectImageNames = [#imageLiteral(resourceName: "TabBarEventSelected"), #imageLiteral(resourceName: "TabBarHomeSelected"), #imageLiteral(resourceName: "TabBarPersonalSelected")]
        
        for (index, itme) in self.tabBar.items!.enumerated() {
            
            var selectImage = selectImageNames[index]
            selectImage = selectImage.withRenderingMode(.alwaysOriginal)
            itme.selectedImage = selectImage
        }
        self.tabBar.tintColor = BASE_COLOR
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
