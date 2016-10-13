//
//  ZYAnchorModel.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/12.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

class ZYAnchorModel: NSObject {

    /// 房间ID
    var room_id : Int = 0
    /// 房间图片对应的URLString
    var vertical_src : String = ""
    /// 判断是手机直播还是电脑直播
    // 0 : 电脑直播 1 : 手机直播
    var isVertical : Int = 0
    /// 房间名称
    var room_name : String = ""
    /// 主播昵称
    var nickname : String = ""
    /// 游戏名称
    var game_name : String = ""
    /// 观看人数
    var online : Int = 0
    /// 所在城市
    var anchor_city : String = ""
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
