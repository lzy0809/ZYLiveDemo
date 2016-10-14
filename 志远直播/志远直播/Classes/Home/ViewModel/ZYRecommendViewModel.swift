//
//  ZYRecommendViewModel.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/12.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit
import SVProgressHUD

class ZYRecommendViewModel{

    //MARK:- 懒加载属性
    /// 最终的数据组
    var anchorGroups: [ZYAnchorGroup] = [ZYAnchorGroup]()
    /// 推荐数据:(头一个:最热)
    fileprivate var hotDataGroup : ZYAnchorGroup = ZYAnchorGroup()
    /// 美颜数据
    fileprivate var prettyGroup: ZYAnchorGroup = ZYAnchorGroup()
    /// 轮播图数据
    lazy var cycleGroups: [ZYCycleModel] = [ZYCycleModel]()
    
}

//MARK:- 发送网络请求
extension ZYRecommendViewModel {
    // 请求推荐数据
    func requestRecommendData(_ recommendDataCallback : @escaping () -> ()) {
        
        //因为要数据整合、所以采用GCD
        let disGroup = DispatchGroup()
        
        disGroup.enter()
        // 1> 请求第一部分推荐数据
        let recoParams = ["time": Date.getCurrentTime(),
                          "messagename": "hotRecommend",]
        ZYNetworkTools.GET_Request(kHomeHotRootUrl, params: recoParams, returnDataType: .JSON) { (responseObj) in
            //处理返回结果
            guard let resultDict = responseObj as? [String : Any] else {return }
            //获取数组
            guard let resultArray = resultDict["data"] as? [[String : Any]] else {return }
            
            self.hotDataGroup.tag_name = "热门"
            self.hotDataGroup.icon_name = "home_header_hot"
            
            //遍历数组,把数组里面的字典-> 模型
            for dict in resultArray {
                let anchor = ZYAnchorModel(dict: dict)
                self.hotDataGroup.anchors.append(anchor)
            }
            disGroup.leave()
        }
        
        // 2> 请求第二部分颜值数据
        let prettyParams = ["limit": "4",
                            "offset": "0",
                            "time": Date.getCurrentTime(),
                            "messagename": "prottyRecommend"]
        disGroup.enter()
        ZYNetworkTools.GET_Request(kHomePrettyRootUrl, params: prettyParams, returnDataType: .JSON) { (result) in
            //处理返回结果
            guard let resultDict = result as? [String : Any] else {return }
            //获取结果数组
            guard let resultArray = resultDict["data"] as? [[String : Any]] else {return }
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            // 字典--> 模型
            for dict in resultArray {
                let anchor = ZYAnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            disGroup.leave()
        }
        
        
        // 3> 请求2-12部分游戏数据
        let playGameParams = ["limit": "4",
                              "offset": "0",
                              "time": Date.getCurrentTime(),
                              "messagename": "playGameRecommend"]
        disGroup.enter()
        ZYNetworkTools.GET_Request(kHomePlayGamesRootUrl, params: playGameParams, returnDataType: .JSON) { (result) in
            // 将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 遍历数组,获取字典,并且将字典转成模型对象
            for dict in dataArray {
                let group = ZYAnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            disGroup.leave()
        }
        
        disGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.hotDataGroup, at: 0)
            recommendDataCallback()
        }
    }
    
    //MARK:- 请求轮播数据
    func requestCycleData(_ requestCycleDataCallback : @escaping () -> ()){
        let cycleParmas = ["version": "2.300"]
        ZYNetworkTools.GET_Request(kHomeCycleRootUrl, params: cycleParmas, returnDataType: .JSON) { (result) in
            //得到数据 校验
            guard let resultDict = result as? [String: Any] else {return }
            // 得到dataArray
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return }
            // 字典--> 模型
            for dict in dataArray {
                self.cycleGroups.append(ZYCycleModel(dict: dict))
            }
            requestCycleDataCallback()
        }
        
    }
}
