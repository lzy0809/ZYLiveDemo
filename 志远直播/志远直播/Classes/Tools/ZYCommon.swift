//
//  ZYCommon.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/9.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

//MARK:- 各种尺寸
let kScreenW: CGFloat = UIScreen.main.bounds.width
let kScreenH: CGFloat = UIScreen.main.bounds.height
let kNavigationBarH: CGFloat = 44
let kStatusBarH: CGFloat = 20
let kTabBarH: CGFloat = 44

//MARK:- 业务逻辑相关
/// 首页推荐
let kHomeHotRootUrl = "http://capi.douyucdn.cn/api/v1/getbigDataRoom"
///首页美颜
let kHomePrettyRootUrl = "http://capi.douyucdn.cn/api/v1/getVerticalRoom"
/// 首页热门（推荐里面的游戏）
let kHomePlayGamesRootUrl = "http://capi.douyucdn.cn/api/v1/getHotCate"
/// 首页轮播
let kHomeCycleRootUrl = "http://www.douyutv.com/api/v1/slide/6"
/// 首页游戏
let kGameMenuRootUrl = "http://capi.douyucdn.cn/api/homeCate/getHotRoom"
/// 首页娱乐
let kAmuseRootUrl = "http://capi.douyucdn.cn/api/v1/getHotRoom/2"
/// 首页趣玩
let kFunnyRootUrl = "http://capi.douyucdn.cn/api/homeCate/getHotRoom"
/// 直播
let kLiveRoomNormalUrl = "http://116.211.167.106/api/live/aggregation"



//MARK:- 自定义打印
func debugPrint<T>(message:T,
              file:String = #file,
              method:String = #function,
              line:Int = #line){
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)],\(method):\(message)")
    #endif
}


