//
//  ZYCollectionNormalViewCell.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/11.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

class ZYCollectionNormalViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var onlineButton: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置圆角
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 5
    }

}
