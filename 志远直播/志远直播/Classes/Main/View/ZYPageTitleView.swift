//
//  ZYPageTitleView.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/9.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//  

import UIKit

fileprivate let kScrollLineH: CGFloat = 2
fileprivate let kBottomLineH: CGFloat = 0.5
private let kNormalColor : (red: CGFloat, green: CGFloat, blue: CGFloat) = (85, 85, 85)
private let kSelectColor : (red: CGFloat, green: CGFloat, blue: CGFloat) = (255, 128, 0)

///定义协议
protocol ZYPageTitleDelegate: class {
    func pageTitleView(pageTitleView: ZYPageTitleView, didSelectedIndex index : Int) -> Void
}

class ZYPageTitleView: UIView {

    //MARK:- 定义属性
    fileprivate var titles: [String]
    fileprivate var titleLabels: [UILabel] = [UILabel]()
    fileprivate var currentIndex: Int = 0
    weak var delegate: ZYPageTitleDelegate?
    //MARK:- 懒加载
    fileprivate lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    fileprivate lazy var scrollLine : UIView = {
       let line = UIView()
        line.backgroundColor = UIColor.orange
        return line
    }()
    
    
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        //布局UI
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:- 布局界面UI
extension ZYPageTitleView {
    
    fileprivate func setupUI(){
        //添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        //添加title对应的Label
        addTitleLabels()
        //添加下面的滚动条
        setupBottomLine()
    }
    
    fileprivate func addTitleLabels(){
        let labelW = frame.width / CGFloat(titles.count)
        let labeH = frame.height - kScrollLineH
        let labelY: CGFloat = 0
        for (index, title) in titles.enumerated() {
            
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.text = title
            label.textAlignment = .center
            label.textColor = UIColor(r: kNormalColor.red, g: kNormalColor.green, b: kNormalColor.blue)
            label.tag = index
            let labelX = CGFloat(index) * labelW
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labeH)
            scrollView.addSubview(label)
            titleLabels.append(label)
            //添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.labelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    fileprivate func setupBottomLine(){
        //添加下面灰色的线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.darkGray
        bottomLine.frame = CGRect(x: 0, y: frame.height - kBottomLineH, width: frame.width, height: kBottomLineH)
        addSubview(bottomLine)
        //添加下面scrollLine
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor(r: kSelectColor.red, g: kSelectColor.green, b: kSelectColor.blue)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
    
    ///label的点击事件
    @objc fileprivate func labelClick(tapGes: UITapGestureRecognizer){
        // 0.获取当前Label
        guard let currentLabel = tapGes.view as? UILabel else { return }
        
        // 1.如果是重复点击同一个Title,那么直接返回
        if currentLabel.tag == currentIndex { return }
        // 2.获取之前的Label
        let oldLabel = titleLabels[currentIndex]
        
        // 3.切换文字的颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        // 4.保存最新Label的下标值
        currentIndex = currentLabel.tag
        
        // 5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15, animations: {
            self.scrollLine.frame.origin.x = scrollLineX
        })
        //通知代理
        delegate?.pageTitleView(pageTitleView: self, didSelectedIndex: currentIndex)
        
    }
}

// MARK:- 对外暴露的方法
extension ZYPageTitleView {
    func setTitleWithProgress(_ progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        // 1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 4.记录最新的index
        currentIndex = targetIndex
    }
}
