//
//  ZYMainViewController.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/9.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

class ZYMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVc(storyboardName: "Home")
        addChildVc(storyboardName: "Live")
        addChildVc(storyboardName: "Follow")
        addChildVc(storyboardName: "Profile")
    }
    
    //MARK:- 添加子控件
    fileprivate func addChildVc(storyboardName: String){
        let childVc = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVc)
    }

}

