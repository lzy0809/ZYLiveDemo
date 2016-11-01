//
//  ZYMenuView.swift
//  志远直播
//
//  Created by 梁志远 on 2016/11/1.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

private let kMenuViewCellID = "kMenuViewCellID"

class ZYMenuView: UIView {
    
    var groups : [ZYAnchorGroup]? {
        didSet{
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
        collectionView.register(UINib.init(nibName: "ZYMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuViewCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}

//MARK:- 提供类方法
extension ZYMenuView {
    class func menuView() -> ZYMenuView {
        return Bundle.main.loadNibNamed("ZYMenuView", owner: nil, options: nil)?.first as! ZYMenuView
    }
}

extension ZYMenuView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil {
            return 0
        }
        let pagNum = (groups!.count - 1) / 8 + 1
        if pagNum == 1 {
            pageControl.isHidden = true
        }else{
            pageControl.isHidden = false
            pageControl.numberOfPages = pagNum
        }
        return pagNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuViewCellID, for: indexPath) as! ZYMenuViewCell
        
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    private func setupCellDataWithCell(cell : ZYMenuViewCell, indexPath : IndexPath) {
        // 0页: 0 ~ 7
        // 1页: 8 ~ 15
        // 2页: 16 ~ 23
        // 1.取出起始位置&终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        // 2.判断越界问题
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        
        // 3.取出数据,并且赋值给cell
        cell.groups = Array(groups![startIndex...endIndex])
    }
}

extension ZYMenuView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
