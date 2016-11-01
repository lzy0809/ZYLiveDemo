//
//  ZYAmuseViewModel.swift
//  志远直播
//
//  Created by 梁志远 on 2016/11/1.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

class ZYAmuseViewModel: ZYBaseViewModel {
 
}

extension ZYAmuseViewModel {
    func loadAmuseData(finishedCallback: @escaping () -> ()) {
        loadAnchorData(isGroupData: true, URLString: kAmuseRootUrl, parameters: nil, finishedCallback: finishedCallback)
    }
}
