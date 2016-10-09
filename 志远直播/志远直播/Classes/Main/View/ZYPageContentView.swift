//
//  ZYPageContentView.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/9.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

private let PageContentCellID = "PageContentCellID"

class ZYPageContentView: UIView {
    
    //MARK:- 定义属性
    fileprivate var childVcs: [UIViewController]
    fileprivate weak var parentVc: UIViewController?
    //MARK:- 懒加载
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
       let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = (self?.bounds.size)!
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: PageContentCellID)
        return collectionView
    }()

    init(frame: CGRect, childVcs: [UIViewController], parentVc: UIViewController) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame: frame)
        //布局UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ZYPageContentView {
    fileprivate func setupUI(){
        //添加子控件到父视图上
        for childVc in childVcs {
            parentVc?.addChildViewController(childVc)
        }
        //添加collectionview
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension ZYPageContentView: UICollectionViewDelegate,UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageContentCellID, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}
