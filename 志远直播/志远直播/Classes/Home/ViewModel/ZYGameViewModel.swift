//
//  ZYGameViewModel.swift
//  志远直播
//
//  Created by 梁志远 on 2016/10/31.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

class ZYGameViewModel : ZYBaseViewModel{
    
}

extension ZYGameViewModel {
    func loadAllGameData(finishedCallback: @escaping () -> ()) {
        let params = ["client_sys" : "ios",
                      "identification" : "ba08216f13dd1742157412386eee1225"]
        loadAnchorData(isGroupData: true, URLString: kGameMenuRootUrl, parameters: params, finishedCallback: finishedCallback)
    }
}
