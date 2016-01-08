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
//                var param = ["mobile":number!]
//                param["password"] = pwd!
//                param["devicetoken"] = "222"
//                Alamofire.request(.POST, "https://childapitest.qupeiyin.com/user/login", parameters: param).responseJSON { (json) -> Void in
//                    print(json.request?.HTTPBody)
//                    print(json.response)
//                    print(json.result.value)
//        }

                API.login(phone: number!, password: pwd!)
                    .subscribeOn(Schedulers.IO())
                    .observeOn(Schedulers.MainScheduler())
                    .subscribe(onNext: { (data) -> Void in
                            print(data)
                        }, onError: { (e) -> Void in
                            print(e)
                        }, onCompleted: { () -> Void in

                        }) { () -> Void in

        }
//                    .subscribe(onNext: { (result) -> Void in
//                            let json = JSON.init(data: result, options: NSJSONReadingOptions.AllowFragments, error: NSErrorPointer.init())
//                            let data = json.dictionaryValue["data"]
//                            print(data)
//
//                        }, onError: { (e) -> Void in
//                           let err = e as! RxCocoaURLError
//                            print(err.code,err.message)
//                        }, onCompleted: { () -> Void in
//
//                        }).addDisposableTo(bag)

    }

    func gotoMain(){
        let main = self.storyboard?.instantiateViewControllerWithIdentifier("MainController") as! MainController
        self.presentViewController(main, animated: true, completion: nil)
    }
    @IBAction func register(sender: AnyObject) {
    }

}