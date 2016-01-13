//
//  LoginController.swift
//  dub
//
//  Created by cuimingqiang on 15/12/22.
//  Copyright © 2015年 cuimingqiang. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import RxSwift
import RxCocoa
import Alamofire
class LoginController: UIViewController {

    @IBOutlet weak var uiphone: UITextField!
    @IBOutlet weak var uipassword: UITextField!

    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(animated: Bool) {
//        gotoMain()
    }
    @IBAction func login(sender: AnyObject) {
                let number = uiphone.text
                let pwd = uipassword.text

                API.login(phone: number!, password: pwd!)
                    .subscribeOn(Schedulers.IO())
                    .observeOn(Schedulers.MainScheduler())
                    .subscribe { (event) -> Void in
                        switch(event){
                        case let .Error(e):
                            print(e)
                        case .Completed:
                            print("Completed")
                        case let .Next(data):
                            RxBus.post(data)
                            RxBus.post(1)
                            print(data.auth_token)
                            self.gotoMain()
                            return
                        }
                    }.addDisposableTo(bag)

    }

    func gotoMain(){
        let main = self.storyboard?.instantiateViewControllerWithIdentifier("MainController") as! MainController
        self.presentViewController(main, animated: true, completion: nil)
    }
    @IBAction func register(sender: AnyObject) {
    }

}