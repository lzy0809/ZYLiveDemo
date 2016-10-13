//
//  ZYRecommendCycleCell.swift
//  志远直播
//
//  Created by 梁志远 on 16/10/12.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

class ZYRecommendCycleCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK:- 定义属性
    var cycleModel: ZYCycleModel? {
        didSet{
            //设置图片
            imageView.kf.setImage(with: URL(string: cycleModel?.pic_url ?? ""), placeholder: UIImage(named: "Img_default"))
        }
    }

}
