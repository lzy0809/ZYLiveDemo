//
//  ZYRecommendGameView.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/13.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 5

class ZYRecommendGameView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- 定义属性
    var gameGroups: [ZYAnchorGroup]? {
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = UIViewAutoresizing()
        
        collectionView.register(UINib(nibName: "ZYCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }

}

//MARK:- 提供一个创建view的类方法
extension ZYRecommendGameView {
    class func recommendGameView () -> ZYRecommendGameView {
        return Bundle.main.loadNibNamed("ZYRecommendGameView", owner: nil, options: nil)?.first as! ZYRecommendGameView
    }
}

//MARK:- 代理方法
extension ZYRecommendGameView: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameGroups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! ZYCollectionGameCell
        cell.gameGroup = gameGroups?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击了第\(indexPath.item)个item")
    }
    
}
