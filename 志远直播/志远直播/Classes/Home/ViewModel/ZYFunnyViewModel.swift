//
//  ZYFunnyViewModel.swift
//  志远直播
//
//  Created by 梁志远 on 2016/11/1.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

class ZYFunnyViewModel: ZYBaseViewModel {

}

extension ZYFunnyViewModel {
    func loadFunnyData(finishedCallback: @escaping () -> ()) {
        let params = ["client_sys" : "ios",
                      "identification" : "393b245e8046605f6f881d415949494c"]
        loadAnchorData(isGroupData: true, URLString: kFunnyRootUrl, parameters: params, finishedCallback: finishedCallback)
    }
}
