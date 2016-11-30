//
//  ZYHomeViewController.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/9.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

fileprivate let kPageTitleViewH: CGFloat = 40

class ZYHomeViewController: UIViewController {
    
    //MARK:- 懒加载
    fileprivate lazy var pageTitleView: ZYPageTitleView = {[weak self] in
        let pageVcFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kPageTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
       let pageView = ZYPageTitleView(frame: pageVcFrame, titles: titles)
        pageView.delegate = self
        return pageView
    }()
    fileprivate lazy var pageContentView: ZYPageContentView = {[weak self] in
       let pageVcFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kPageTitleViewH, width: kScreenW, height: kScreenH - kStatusBarH - kNavigationBarH - kPageTitleViewH - kTabBarH)
        var childVcs = [UIViewController]()
        childVcs.append(ZYRecommendViewController())
        childVcs.append(ZYGameViewController())
        childVcs.append(ZYAmuseViewController())
        childVcs.append(ZYFunnyViewController())
        let contentView = ZYPageContentView(frame: pageVcFrame, childVcs: childVcs, parentVc: self)
        contentView.delegate = self
        return contentView
    }()
    
    //MARK:- 生命周期函数
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI布局
        setupUI()
    }

}

//MARK:- 设置UI布局
extension ZYHomeViewController {
    fileprivate func setupUI(){
        //不要设置UIscrollview的内边距  ⚠️妈蛋的，不设置的话 pageView上的label粗不来！
        automaticallyAdjustsScrollViewInsets = false
        //设置导航栏按钮
        setupNavigationBarButoon()
        //添加pageTitleView
        view.addSubview(pageTitleView)
        //添加pageContentView
        view.addSubview(pageContentView)
    }
    
    private func setupNavigationBarButoon(){
        //导航栏左侧按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo", target: self, action: #selector(self.logoClick))
        //导航栏右侧按钮
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size, target: self, action: #selector(self.historyClick))
        
        let scanItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size, target: self, action: #selector(self.scanClick))
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size, target: self, action: #selector(self.searchClick))
        navigationItem.rightBarButtonItems = [historyItem, scanItem, searchItem]
    }
    
}

//MARK:- 导航栏按钮点击事件
extension ZYHomeViewController {
    @objc fileprivate func logoClick(){
        debugPrint(message: "点击了logo按钮")
    }
    @objc fileprivate func historyClick(){
        debugPrint(message: "点击了历史记录按钮")
    }
    @objc fileprivate func scanClick(){
        debugPrint(message: "点击了二维码按钮")
    }
    @objc fileprivate func searchClick(){
        debugPrint(message: "点击了搜索按钮")
    }
}

//MARK:- 协议的代理方法
extension ZYHomeViewController : ZYPageTitleDelegate, PageContentViewDelegate{
    
    ///ZYPageTitleDelegate代理方法
    func pageTitleView(pageTitleView: ZYPageTitleView, didSelectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
    }
    ///PageContentViewDelegate代理方法
    func pageContentView(_ contentView: ZYPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

