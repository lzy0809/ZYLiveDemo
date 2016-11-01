//
//  ZYFunnyViewController.swift
//  志远直播
//
//  Created by 梁志远 on 2016/11/1.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//  Function : 趣玩界面

import UIKit

class ZYFunnyViewController: ZYBaseAnchorViewController {

    //MARK: 懒加载属性
    fileprivate lazy var funnyVM: ZYFunnyViewModel = ZYFunnyViewModel()
    fileprivate lazy var funnyMenuView : ZYMenuView = {
        let menuView = ZYMenuView.menuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()
}

//MARK:- 布局界面
extension ZYFunnyViewController {
    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(funnyMenuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

extension ZYFunnyViewController {
    override func loadData() {
        baseVM = funnyVM
        funnyVM.loadFunnyData{
            self.collectionView.reloadData()
            self.funnyVM.anchorGroups.removeFirst()
            if self.funnyVM.anchorGroups.count > 16 {
                let moreGroup = ZYAnchorGroup()
                moreGroup.tag_name = "更多"
                self.funnyVM.anchorGroups.insert(moreGroup, at: 15)
                self.funnyMenuView.groups = Array(self.funnyVM.anchorGroups[0..<16])
            }else{
                self.funnyMenuView.groups = self.funnyVM.anchorGroups
            }
            self.loadDataFinished()
        }
    }
}
