//
//  ZYRecommendViewController.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/11.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//  Function : 推荐界面

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW: CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
///美颜Item的高
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH: CGFloat = 50

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

///普通的cell
private let kNormalCellID = "kNormalCellID"
///美颜cell
private let kPrettyCellID = "kPrettyCellID"
///sectionHeaderView
private let kHeaderViewID = "kHeaderViewID"

class ZYRecommendViewController: UIViewController {
    
    //MARK:- 懒加载控件
    fileprivate lazy var recommendVM : ZYRecommendViewModel = ZYRecommendViewModel()
    
    fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumInteritemSpacing = kItemMargin
        layout.minimumLineSpacing = 0
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        collectionView.register(UINib(nibName: "ZYCollectionNormalViewCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "ZYPrettyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "ZYCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
        }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //设置UI布局
        setupUI()
        //发送网络请求
        sendRequest()
    }
}

//MARK:- 设计UI布局
extension ZYRecommendViewController {
    
    fileprivate func setupUI(){
        view.addSubview(collectionView)
        //添加轮播的view
        collectionView.addSubview(cycleView)
        //添加游戏view
        collectionView.addSubview(gameView)
    }
}

//MARK:- 发送网络请求
extension ZYRecommendViewController {
    //发送网络请求
    fileprivate func sendRequest(){
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
        }
        
        //发送轮播图的网络请求
        recommendVM.requestCycleData { 
            self.cycleView.cycleGroups = self.recommendVM.cycleGroups
        }
    }
}

extension ZYRecommendViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    //UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        var cell : ZYCollectionBaseCell!
        
        if indexPath.section == 1 {//美颜
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! ZYPrettyCollectionViewCell
        }
        else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! ZYCollectionNormalViewCell
        }
        cell.anchor = anchor
        
        return cell
    }
    //分组的header或者footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as! ZYCollectionHeaderView
        
        headerView.headerGroup = recommendVM.anchorGroups[indexPath.section]
        
        return headerView
    }
    
    //UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {//美颜
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}

