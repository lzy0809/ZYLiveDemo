//
//  ZYCollectionHeaderView.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/11.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

class ZYCollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var headerNameLabel: UILabel!
    
        override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK:- 定义数据模型
    var headerGroup: ZYAnchorGroup? {
        didSet{
            guard let headerGroup = headerGroup else {
                return
            }
            headerNameLabel.text = headerGroup.tag_name
            iconImageView.image = UIImage(named: headerGroup.icon_name ?? "home_header_normal")
        }
    }
    
    //MARK:- 点击"更多"按钮
    @IBAction func moreButtonClick(_ sender: AnyObject) {
        print("点击了'更多'按钮")
    }
}
