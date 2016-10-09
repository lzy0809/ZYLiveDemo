//
//  UIBarButtonItem-Extension.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/9.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(imageName: String, highImageName: String = "", size:CGSize = CGSize.zero, target: Any?, action: Selector) {
        let button = UIButton()
        button.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            button.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            button.sizeToFit()
        }
        else{
            button.frame.size = size
        }
        button.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: button)
    }
}
