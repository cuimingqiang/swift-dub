//
//  TeacherController.swift
//  dub
//
//  Created by cuimingqiang on 15/12/18.
//  Copyright © 2015年 cuimingqiang. All rights reserved.
//

import Foundation
import UIKit

class MineController : UIViewController {
    var data :Array<Any> = []
    var section :[Int] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.alwaysBounceHorizontal = false //禁止左右移动
        //由于先加nav 再加入tableview 所以向下偏移了一个nav 
        tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0)
        print("MineController")
    }
    func initData(){
        data.append(Item.init(image: "", title: "个人信息"))
        section.append(1)
        data.append(Item.init(image: "my_dub", title: "我的配音"))
        data.append(Item.init(image: "my_favor", title: "我的收藏"))
//        data.append(Item.init(image: "my_dub", title: "视频缓存"))
        data.append(Item.init(image: "my_photo", title: "我的相册"))
        data.append(Item.init(image: "my_nwordbook", title: "生词本"))
        section.append(4)
        data.append(Item.init(image: "my_activity", title: "精彩活动"))
        section.append(1)
        data.append(Item.init(image: "my_share", title: "告诉朋友"))
        section.append(1)
    }
}

extension MineController : UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.section[section]
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let nib = UINib(nibName: "OnLogoffView", bundle: nil)
            let view = nib.instantiateWithOwner(self, options: nil)[0] as! OnLogoffViewController
            view.selectionStyle = UITableViewCellSelectionStyle.None
            let logoffButton = view.logoff
            logoffButton.backgroundColor = UIColor.init(red: 137/255, green: 202/255, blue: 48/255, alpha: 1.0)
            logoffButton.layer.cornerRadius = 5
            return view
        }
        let nib = UINib(nibName: "SettingItemView", bundle: nil)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UITableViewCell

        var row = 0
        for var i = 0 ; i < indexPath.section ; i++ {
            row += section[i]
        }
        
        let _data : Any = data[indexPath.row + row]
        switch(_data){
            case let _item as Item:
                let setting = view as! SettingItemController
                setting.title.text = _item.title
                setting.icon?.image = UIImage(named: _item.image)
        default:
            print("")
        }
        return view
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return section.count
    }

}

extension MineController : UITableViewDelegate{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 80
        }
        return 44
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

struct Item {
    var image : String
    var title : String
}
