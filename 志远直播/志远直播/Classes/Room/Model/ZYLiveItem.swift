//
//  ZYLiveItem.swift
//  志远直播
//
//  Created by 梁志远 on 2016/11/30.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

class ZYLiveItem: NSObject {
    /// 直播流地址
    var stream_addr : String = ""
    /// 关注人
    var online_users : Int = 0
    /// 城市
    var city : String = ""
    /// 主播信息对应的字典
    var creator : [String : Any]? {
        didSet {
            guard let creator = creator else  { return }
            creator_list = YZCreatorItem(dict: creator)
        }
    }
    /// 主播
    var creator_list : YZCreatorItem?
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}


class YZCreatorItem: NSObject {
    /// 主播名
    var nick : String = ""
    /// 主播头像
    var portrait : String = ""
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
