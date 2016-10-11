//
//  ZYCollectionHeaderView.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/11.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

class ZYCollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var headerNameLabel: UILabel!
        override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK:- 点击"更多"按钮
    @IBAction func moreButtonClick(_ sender: AnyObject) {
        print("点击了'更多'按钮")
    }
}
