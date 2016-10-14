//
//  ZYCollectionNormalViewCell.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/11.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

class ZYCollectionNormalViewCell: ZYCollectionBaseCell {

    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    override var anchor: ZYAnchorModel? {
        didSet{
            super.anchor = anchor
            roomNameLabel.text = anchor?.room_name
        }
    }
    
    

}
