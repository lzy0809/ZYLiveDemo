//
//  ZYCycleModel.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/12.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

class ZYCycleModel: NSObject {
    
    /// 标题
    var title : String = ""
    /// 展示的图片地址
    var pic_url : String = ""
    /// 主播信息对应的字典
    var room : [String : Any]? {
        didSet {
            guard let room = room else  { return }
            anchor = ZYAnchorModel(dict: room)
        }
    }
    /// 主播信息对应的模型对象
    var anchor : ZYAnchorModel?
    
    
    /// MARK:- 自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
