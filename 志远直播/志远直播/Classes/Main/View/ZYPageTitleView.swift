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

class ZYPageTitleView: UIView {

    //MARK:- 定义属性
    fileprivate var titles: [String]
    fileprivate var titleLabels: [UILabel] = [UILabel]()
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
            let labelX = CGFloat(index) * labelW
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labeH)
            scrollView.addSubview(label)
            titleLabels.append(label)
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
    

}
