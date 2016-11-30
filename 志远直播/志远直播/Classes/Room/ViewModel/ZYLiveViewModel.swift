//
//  ZYLiveViewModel.swift
//  志远直播
//
//  Created by 梁志远 on 2016/11/30.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

class ZYLiveViewModel {
    lazy var lives : [ZYLiveItem] = [ZYLiveItem]()
}

extension ZYLiveViewModel{
    func loadLiveData(finishedCallback: @escaping () -> ()) {
        let params = ["uid" : "133825214",
                      "interest" : "1"]
        ZYNetworkTools.GET_Request(kLiveRoomNormalUrl, params: params, returnDataType: .JSON) { (result) in
            
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["lives"] as? [[String : Any]] else { return }
            
            for dict in dataArray {
                self.lives.append(ZYLiveItem(dict: dict))
                
            }
            finishedCallback()
        }
    }
}

