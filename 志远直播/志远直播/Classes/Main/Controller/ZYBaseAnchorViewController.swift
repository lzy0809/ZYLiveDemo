//
//  ZYBaseAnchorViewController.swift
//  志远直播
//
//  Created by 梁志远 on 2016/10/31.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

///普通的cell
private let kNormalCellID = "kNormalCellID"
///sectionHeaderView
private let kHeaderViewID = "kHeaderViewID"

///美颜cell
let kPrettyCellID = "kPrettyCellID"
let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3

class ZYBaseAnchorViewController: ZYBaseViewController {

    //MARK:- 定义属性
    var baseVM : ZYBaseViewModel!
    lazy var collectionView : UICollectionView = {[unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UINib(nibName: "ZYCollectionNormalViewCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "ZYPrettyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "ZYCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global().async {
            self.loadData()
            DispatchQueue.main.async {
                self.setupUI()
            }
        }
    }
}

//MARK:- 界面布局
extension ZYBaseAnchorViewController {
    override func setupUI() {
        contentView = collectionView
        view.addSubview(collectionView)
        super.setupUI()
    }
}

//MARK:- 发送网络请求
extension ZYBaseAnchorViewController {
    func loadData() {
        
    }
}

//MARK:- 遵守UICollectionView数据源代理
extension ZYBaseAnchorViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! ZYCollectionNormalViewCell
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! ZYCollectionHeaderView
        headerView.headerGroup = baseVM.anchorGroups[indexPath.section]
        return headerView
    }
}
// MARK:- 遵守UICollectionView的代理协议
extension ZYBaseAnchorViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 1.取出对应的主播信息
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        // 2.判断是秀场房间&普通房间
        anchor.isVertical == 0 ? pushNormalRoomVc() : presentShowRoomVc()
    }
    // 以Modal方式弹出
    private func presentShowRoomVc() {
        let showRoomVc = ZYRoomShowViewController()
        present(showRoomVc, animated: true, completion: nil)
    }
    // 以Push方式弹出
    private func pushNormalRoomVc() {
        let normalRoomVc = ZYRoomNormalViewController()
        navigationController?.pushViewController(normalRoomVc, animated: true)
    }
}

