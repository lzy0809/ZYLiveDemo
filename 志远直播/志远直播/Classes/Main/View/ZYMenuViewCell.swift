//
//  ZYMenuViewCell.swift
//  志远直播
//
//  Created by 梁志远 on 2016/11/1.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

private let kMenuCellID = "kMenuCellID"

class ZYMenuViewCell: UICollectionViewCell {
    
    var groups : [ZYAnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib.init(nibName: "ZYCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.size.width / 4
        let itemH = collectionView.bounds.size.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }
}

//MARK:- 数据源代理
extension ZYMenuViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! ZYCollectionGameCell
        
        cell.gameGroup = groups![indexPath.item]
        cell.clipsToBounds = true
        
        return cell
    }
}
