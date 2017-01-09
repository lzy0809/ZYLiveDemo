//
//  ZYLiveRoomViewController.swift
//  志远直播
//
//  Created by 梁志远 on 2016/11/30.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit
//import IJKMediaFramework

class ZYLiveRoomViewController: UIViewController {

    
//    var player:IJKFFMoviePlayerController?
    
    fileprivate var liveUrl:URL?
    
    
    var roomLive: ZYLiveItem?{
        didSet{
            guard let roomLive = roomLive else {
                return
            }
            guard let creator = roomLive.creator_list else {
                return
            }
            let imageUrl = "http://img.meelive.cn/\(creator.portrait)"
            imageV.kf.setImage(with: URL(string: imageUrl))
            
            liveUrl = URL(string: roomLive.stream_addr)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "直播间"
        view.backgroundColor = UIColor.white
        view.addSubview(imageV)
        view.addSubview(backButton)
        createPlayer()
//        view.insertSubview(player.view, at: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        ///界面消失，一定要记得停止播放
//        player.pause()
//        player.stop()
    }
    
    ///返回按钮
    lazy var backButton:UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 30, width: 40, height: 40))
        button.setTitle("返回", for: UIControlState())
        button.setTitleColor(UIColor.red, for: UIControlState())
        button.addTarget(self, action: #selector(ZYLiveRoomViewController.back), for: UIControlEvents.touchUpInside)
        button.alpha = 0.01
        return button
    }()
    /*
    fileprivate lazy var player:IJKFFMoviePlayerController = {
    let playVc = IJKFFMoviePlayerController(contentURL: self.liveUrl, with: nil)
        playVc?.view.frame = self.view.bounds
        return playVc!
    }()
    */
    lazy var imageV: UIImageView = {
        let imgV = UIImageView(frame: CGRect(x: 0, y: 64, width: kScreenW, height: kScreenW-64))
        return imgV
    }()
    
    func back() -> () {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        UIView.animate(withDuration: 0.25, animations: {
            if self.backButton.alpha == 1 {
                self.backButton.alpha = 0.01
            }
            else{
                self.backButton.alpha = 1
            }
        })
    }

}

extension ZYLiveRoomViewController{
    fileprivate func createPlayer(){
        /*
        player = IJKFFMoviePlayerController(contentURL: liveUrl, with: nil)
        player.view.frame = UIScreen.main.bounds
        player.prepareToPlay()
         */
    }
}
