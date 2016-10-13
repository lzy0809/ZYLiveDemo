//
//  ZYCollectionGameCell.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/13.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

class ZYCollectionGameCell: UICollectionViewCell {

    //MARK:- 定义控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    //MARK:- 定义属性
    var gameGroup: ZYAnchorGroup? {
        didSet{
            nameLabel.text = gameGroup?.tag_name
            iconImageView.kf.setImage(with: URL(string: gameGroup?.icon_url ?? ""), placeholder: UIImage(named: "home_more_btn"))
        }
    }
    
    //MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
//        // 设置圆角
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 30
        
    }

}
