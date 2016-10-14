//
//  ZYCollectionBaseCell.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/12.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit
import Kingfisher

class ZYCollectionBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置圆角
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 5
        
        onlineButton.layer.masksToBounds = true
        onlineButton.layer.cornerRadius = 3
    }
    
    //MARK:- 定义数据模型
    var anchor: ZYAnchorModel? {
        didSet{
            guard let anchor = anchor else {
                return
            }
            // 在线人数
            var onlineCount: String = ""
            if anchor.online >= 10000 {
                onlineCount = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineCount = "\(anchor.online)在线"
            }
            onlineButton.setTitle(onlineCount, for: .normal)
            //昵称
            nickNameLabel.text = anchor.nickname
            //封面设置
            iconImageView.kf.setImage(with: URL(string: anchor.vertical_src), placeholder: UIImage(named: "live_cell_default_phone"))
        }
    }
}
