//
//  QLRunningRecordViewController.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/27.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit

class QLRunningRecordViewController: QLBaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func runButtonAction(_ sender: Any) {
        
        let runningVC = self.storyboard?.instantiateViewController(withIdentifier: "QLRunningViewController") as! QLRunningViewController
        self.present(runningVC, animated: true, completion: nil)
    }
    
    @IBAction func warmUpButtonAction(_ sender: Any) {
        
        
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

extension QLRunningRecordViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QLRunningMapCell", for: indexPath) as! QLRunningMapCell
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QLRunningTotalCell", for: indexPath) as! QLRunningTotalCell
            return cell
        }
    }
}

extension QLRunningRecordViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = SCREEN_WIDTH - 40
        let height = width * 4 / 3
        return CGSize(width: width, height: height)
    }
}




