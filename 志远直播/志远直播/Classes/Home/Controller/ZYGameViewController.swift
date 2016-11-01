//
//  ZYGameViewController.swift
//  志远直播
//
//  Created by 梁志远 on 2016/10/31.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//  Function : 游戏界面

import UIKit

let kMenuViewH : CGFloat = 200

class ZYGameViewController: ZYBaseAnchorViewController {

    //MARK: 懒加载属性
    fileprivate lazy var gameVM: ZYGameViewModel = ZYGameViewModel()
    fileprivate lazy var gameMenuView : ZYMenuView = {
       let menuView = ZYMenuView.menuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()
    
}

//MARK:- 布局界面
extension ZYGameViewController {
    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(gameMenuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK:- 加载数据
extension ZYGameViewController {
    override func loadData() {
        baseVM = gameVM
        gameVM.loadAllGameData { 
            self.collectionView.reloadData()
            self.gameVM.anchorGroups.removeFirst()
            if self.gameVM.anchorGroups.count > 16 {
                let moreGroup = ZYAnchorGroup()
                moreGroup.tag_name = "更多"
                self.gameVM.anchorGroups.insert(moreGroup, at: 15)
                self.gameMenuView.groups = Array(self.gameVM.anchorGroups[0..<16])
            }else{
                self.gameMenuView.groups = self.gameVM.anchorGroups
            }
            self.loadDataFinished()
        }
    }
}

