//
//  ZYBaseGameModel.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/12.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

class ZYBaseGameModel: NSObject {
    // MARK:- 定义属性
    var tag_name : String = ""
    var icon_url : String = ""
    
    // MARK:- 自定义构造函数
    override init() {
        
    }
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
