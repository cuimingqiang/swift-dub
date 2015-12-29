//
//  LoginController.swift
//  dub
//
//  Created by cuimingqiang on 15/12/22.
//  Copyright © 2015年 cuimingqiang. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
class AdController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("AdController")

    }
    override func viewDidAppear(animated: Bool) {
        gotoLogin()
    }
    func gotoMain(){
        print("======")
        let main = self.storyboard?.instantiateViewControllerWithIdentifier("MainController") as! MainController
        self.presentViewController(main, animated: true, completion: nil)
    }
    func gotoLogin(){
        let login = self.storyboard?.instantiateViewControllerWithIdentifier("LoginController") as! LoginController
        self.presentViewController(login, animated: true, completion: nil)
    }
}