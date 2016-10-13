//
//  ZYPrettyCollectionViewCell.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/11.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

class ZYPrettyCollectionViewCell: ZYCollectionBaseCell {

    @IBOutlet weak var cityButton: UIButton!
    
    override var anchor: ZYAnchorModel? {
        didSet{
            super.anchor = anchor
            cityButton.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
}
