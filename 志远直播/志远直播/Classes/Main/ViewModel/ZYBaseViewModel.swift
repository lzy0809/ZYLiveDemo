//
//  ZYBaseViewModel.swift
//  志远直播
//
//  Created by 梁志远 on 2016/10/31.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

class ZYBaseViewModel{
    lazy var anchorGroups : [ZYAnchorGroup] = [ZYAnchorGroup]()
}

extension ZYBaseViewModel {
    func loadAnchorData(isGroupData : Bool, URLString : String, parameters : [String : String]? = nil, finishedCallback : @escaping () -> ()) {
     
        ZYNetworkTools.GET_Request(URLString, params: parameters, returnDataType: .JSON) { (result) in
            
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }

            if isGroupData {
                for dict in dataArray {
                    self.anchorGroups.append(ZYAnchorGroup(dict: dict))
                }
            } else  {
                let group = ZYAnchorGroup()
                for dict in dataArray {
                    group.anchors.append(ZYAnchorModel(dict: dict))
                }
                self.anchorGroups.append(group)
            }
            finishedCallback()
        }
    }
}
