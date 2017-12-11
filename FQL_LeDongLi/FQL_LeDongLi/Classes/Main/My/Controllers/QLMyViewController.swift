//
//  QLMyViewController.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/2.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit

class QLMyViewController: QLBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var myInfoVC: QLMyInfoViewController?
    
    var infos:[[String: Any]] = [["image": #imageLiteral(resourceName: "PersonalCenterGroup"), "title": "我的群组"],
                                    ["image": #imageLiteral(resourceName: "PersonalCenterMessageCenter"), "title": "消息中心"],
                                    ["image": #imageLiteral(resourceName: "PersonalCenterOnlinePlaceholder"), "title": "账户"],
                                    ["image": #imageLiteral(resourceName: "PersonalCenterSetting"), "title": "设置"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSubViews()
    }
    
    private func setSubViews() {
        self.tableView.tableHeaderView = self.headerView
        self.tableView.scrollsToTop = false

        myInfoVC = QLMyInfoViewController()
        UIApplication.shared.keyWindow?.addSubview(myInfoVC!.view)
        myInfoVC!.view.snp.makeConstraints { (make) in
            make.top.equalTo(-SCREEN_HEIGHT)
            make.left.right.equalToSuperview()
            make.height.equalTo(SCREEN_HEIGHT)
        }
    }
    
    fileprivate func showMyInfoView() {
        
        myInfoVC?.view.snp.updateConstraints({ (make) in
            make.top.equalTo(0)
        })
        UIView.animate(withDuration: 1) {
            UIApplication.shared.keyWindow?.layoutIfNeeded()
        }
    }

    lazy var headerView: YXWaveView = {
        let rect = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 200)
        let headerView = YXWaveView(frame: rect, color: UIColor(white: 1, alpha: 0.6))
        headerView.backgroundColor = UIColor.clear
        headerView.addOverView(self.userInfoView)
        headerView.waveHeight = 8
        headerView.waveSpeed = 0.5
        headerView.start()
        return headerView
    }()
    
    lazy var userInfoView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 120))
        view.addSubview(userImageView)
        view.addSubview(nikeNameLabel)
        view.addSubview(downButton)
        
        return view
    }()
    
    lazy var userImageView: UIImageView = {
        let userImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        userImageView.image = #imageLiteral(resourceName: "itemImage")
        userImageView.layer.cornerRadius = 40
        userImageView.layer.borderWidth = 3
        userImageView.layer.borderColor = UIColor(white: 1, alpha: 0.5).cgColor
        userImageView.layer.masksToBounds = true
        
        return userImageView
    }()
    
    lazy var nikeNameLabel: UILabel = {
        let nikeNameLabel = UILabel(frame: CGRect(x: 0, y: 80, width: 80, height: 20))
        nikeNameLabel.text = "Kinglin"
        nikeNameLabel.textColor = UIColor.white
        nikeNameLabel.font = UIFont.systemFont(ofSize: 15)
        nikeNameLabel.textAlignment = .center
        
        return nikeNameLabel
    }()
    
    lazy var downButton: UIButton = {
        let downButton = UIButton.init(type: .custom)
        downButton.frame = CGRect(x: 0, y: 100, width: 80, height: 20)
        downButton.setImage(#imageLiteral(resourceName: "PersonalCenterDownArrow"), for: .normal)
        
        return downButton
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension QLMyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.infos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QLMyPageCell", for: indexPath) as! QLMyPageCell
        cell.infoDic = self.infos[indexPath.row]
        return cell
    }
}

extension QLMyViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let y_offSet = scrollView.contentOffset.y
        if y_offSet >= -100 && y_offSet <= -80 {

            self.showMyInfoView()
        }
    }
}

