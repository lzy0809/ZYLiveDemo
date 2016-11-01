//
//  ZYRecommendViewController.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/11.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//  Function : 推荐界面

import UIKit

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90



class ZYRecommendViewController: ZYBaseAnchorViewController {
    
    //MARK:- 懒加载控件
    fileprivate lazy var recommendVM : ZYRecommendViewModel = ZYRecommendViewModel()
    fileprivate lazy var cycleView: ZYRecommendCycleView = {
       let cycleView = ZYRecommendCycleView.recomendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    fileprivate lazy var gameView: ZYRecommendGameView = {
       let gameView = ZYRecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
}

//MARK:- 设计UI布局
extension ZYRecommendViewController {
    
    override func setupUI(){
        super.setupUI()
        //添加轮播的view
        collectionView.addSubview(cycleView)
        //添加游戏view
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK:- 发送网络请求
extension ZYRecommendViewController {
    //发送网络请求
    override func loadData(){
        
        baseVM = recommendVM
        
        //请求首页推荐、美颜、游戏数据的网络请求
        recommendVM.requestRecommendData {
            //刷新界面
            self.collectionView.reloadData()
            
            var gameGroups = self.recommendVM.anchorGroups
            
            gameGroups.removeFirst()
            gameGroups.removeFirst()
            
            let moreGroup = ZYAnchorGroup()
            moreGroup.tag_name = "更多"
            gameGroups.append(moreGroup)
            
            self.gameView.gameGroups = gameGroups
            
            self.loadDataFinished()
        }
        
        //发送轮播图的网络请求
        recommendVM.requestCycleData { 
            self.cycleView.cycleGroups = self.recommendVM.cycleGroups
        }
    }
}

//MARK:- UICollectionViewDelegateFlowLayout代理方法
extension ZYRecommendViewController : UICollectionViewDelegateFlowLayout {

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            // 1.取出PrettyCell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! ZYPrettyCollectionViewCell
            
            // 2.设置数据
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return prettyCell
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {//美颜
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}
