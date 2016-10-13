//
//  ZYRecommendCycleView.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/12.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit
private let kRecommendCycleCellID = "kRecommendCycleCellID"

class ZYRecommendCycleView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK:- 定义属性
    var cycleTimer: Timer?
    
    var cycleGroups: [ZYCycleModel]? {
        didSet{
            //界面刷新
            collectionView.reloadData()
            
            pageControl.numberOfPages = cycleGroups?.count ?? 0
            //默认滚动到中间某一个位置
            let indexPatch = IndexPath(item: (cycleGroups?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPatch, at: .left, animated: false)
            
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        //注册cell
        collectionView.register(UINib(nibName: "ZYRecommendCycleCell", bundle: nil), forCellWithReuseIdentifier: kRecommendCycleCellID)
        collectionView.bounces = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //在awakeFromNib方法里设置frame属性是不准确的,因为他会以xib里面的尺寸为准,而不是后来设置的尺寸
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
    
}

//MARK:- 提供一个快速创建View的类方法
extension ZYRecommendCycleView {
    class func recomendCycleView() -> ZYRecommendCycleView {
        return Bundle.main.loadNibNamed("ZYRecommendCycleView", owner: nil, options: nil)?.first as! ZYRecommendCycleView
    }
}

//MARK:- UICollectionViewDataSource, UICollectionViewDelegate
extension ZYRecommendCycleView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleGroups?.count ?? 0) * 10000
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommendCycleCellID, for: indexPath) as! ZYRecommendCycleCell
        cell.cycleModel = cycleGroups?[indexPath.item % cycleGroups!.count]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        // 计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleGroups?.count ?? 1)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addCycleTimer()
    }
}


//MARK:- 对定时器的操作方法
extension ZYRecommendCycleView {
    
    fileprivate func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    
    fileprivate func removeCycleTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc fileprivate func scrollToNext() {
        // 获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        // 滚动该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
