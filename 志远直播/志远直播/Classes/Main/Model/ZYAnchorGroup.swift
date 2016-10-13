//
//  ZYAnchorGroup.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/12.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

class ZYAnchorGroup: ZYBaseGameModel {

    /// 该组中对应的房间信息
    var room_list: [[String : Any]]? {
        didSet{
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                anchors.append(ZYAnchorModel(dict: dict))
            }
        }
    }
    /// 组显示的图标
    var icon_name : String?
    /// 标签tag
    var tag_id: Int = 0
    /// 定义主播的模型对象数组
    lazy var anchors : [ZYAnchorModel] = [ZYAnchorModel]()
}
