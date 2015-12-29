//
//  ViewController.swift
//  dub
//
//  Created by cuimingqiang on 15/12/4.
//  Copyright © 2015年 cuimingqiang. All rights reserved.
//

import UIKit
import RxSwift
class MainController: UITabBarController {
    
    @IBOutlet weak var tabTab: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
//        tabTab.tintColor = UIColor(CIColor: CIColor.init(red: 137, green: 202, blue: 48))
//        tabTab.tintColor = UIColor(red: CGFloat.init(floatLiteral: 0.54), green: CGFloat.init(floatLiteral:0.79), blue: CGFloat.init(floatLiteral: 0.19), alpha: CGFloat.init(floatLiteral: 1))

        tabTab.tintColor = UIColor.init(red: 137/255, green: 202/255, blue: 48/255, alpha: 1.0)
        print("MainController")
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

