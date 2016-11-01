//
//  ZYAmuseViewController.swift
//  志远直播
//
//  Created by 梁志远 on 2016/11/1.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//  Function : 娱乐界面

import UIKit

class ZYAmuseViewController: ZYBaseAnchorViewController {

    //MARK: 懒加载属性
    fileprivate lazy var amuseVM: ZYAmuseViewModel = ZYAmuseViewModel()
    fileprivate lazy var amuseMenuView : ZYMenuView = {
        let menuView = ZYMenuView.menuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()
}

//MARK:- 布局界面
extension ZYAmuseViewController {
    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(amuseMenuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

extension ZYAmuseViewController {
    override func loadData() {
        baseVM = amuseVM
        amuseVM.loadAmuseData{
            self.collectionView.reloadData()
            self.amuseVM.anchorGroups.removeFirst()
            if self.amuseVM.anchorGroups.count > 16 {
                let moreGroup = ZYAnchorGroup()
                moreGroup.tag_name = "更多"
                self.amuseVM.anchorGroups.insert(moreGroup, at: 15)
                self.amuseMenuView.groups = Array(self.amuseVM.anchorGroups[0..<16])
            }else{
                self.amuseMenuView.groups = self.amuseVM.anchorGroups
            }
            self.loadDataFinished()
        }
    }
}
