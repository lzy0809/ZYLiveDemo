//
//  ZYRoomNormalViewController.swift
//  志远直播
//
//  Created by 梁志远 on 2016/10/31.
//  Copyright © 2016年 soufunmedia. All rights reserved.
//

import UIKit

private let liveCellID = "liveCellID"

class ZYRoomNormalViewController: UIViewController {

//    @IBOutlet weak var tableView: UITableView!
    fileprivate lazy var liveVM : ZYLiveViewModel = ZYLiveViewModel()
    fileprivate lazy var tableView:UITableView = {[unowned self] in
       let tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
        
        setupTableView()
        
        loadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 隐藏导航栏
//        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}

extension ZYRoomNormalViewController{
    fileprivate func setupTableView(){
        tableView.register(UINib(nibName: "ZYLiveTableViewCell", bundle: nil), forCellReuseIdentifier: liveCellID)
        view.addSubview(tableView)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
    
    fileprivate func loadData(){
        liveVM.loadLiveData {
            
            self.tableView.reloadData()
        }
    }
}

extension ZYRoomNormalViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liveVM.lives.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: liveCellID, for: indexPath) as! ZYLiveTableViewCell
        cell.live = liveVM.lives[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 430
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let vc = ZYLiveRoomViewController()
        vc.roomLive = liveVM.lives[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
}
