//
//  ZYLiveTableViewCell.swift
//  志远直播
//
//  Created by 梁志远 on 2016/11/30.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

class ZYLiveTableViewCell: UITableViewCell {

    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var liveLabel: UILabel!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var chaoyangLabel: UILabel!
    @IBOutlet weak var bigPicView: UIImageView!
    var live:ZYLiveItem?{
        didSet{
            guard let live = live else {
                return
            }
            guard let creator = live.creator_list else {
                return
            }
            let imageUrl = "http://img.meelive.cn/\(creator.portrait)"
            headImageView.kf.setImage(with: URL(string: imageUrl))
            bigPicView.kf.setImage(with: URL(string: imageUrl))
            
            if live.city.isEmpty {
                addressLabel.text = "难道在火星?"
            }else{
                addressLabel.text = live.city
            }
            nameLabel.text = creator.nick
            chaoyangLabel.text = "\(live.online_users)人在看"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headImageView.layer.cornerRadius = 5
        headImageView.layer.masksToBounds = true
        
        liveLabel.layer.cornerRadius = 5
        liveLabel.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
