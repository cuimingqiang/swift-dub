//
//  API.swift
//  dub
//
//  Created by cuimingqiang on 15/12/23.
//  Copyright © 2015年 cuimingqiang. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import SwiftyJSON

enum HTTPMethod{
    case POST
    case GET
}
extension HTTPMethod{
    internal var string :String{
        switch(self){
        case .POST:
            return "POST"
        case .GET:
            return "GET"
        }
    }
}
class API{
    static let server_url = "https://childapitest.qupeiyin.com"

    class func request<O:JsonToObject where O.E == O>(url path:String,method:HTTPMethod,param:Dictionary<String,String>)->Observable<Array<O>>{
        return request(url: path, method: method, param: param).flatMap({ (data) -> Observable<Array<O>> in
            return flatmap(data)
        })

    }
    class func request<O: JsonToObject where O.E == O>(url path:String,method:HTTPMethod,param:Dictionary<String,String>)->Observable<O>{
        return request(url: path, method: method, param: param).flatMap({ (data) -> Observable<O> in
            return flatmap(data)
        })
    }
    class func request(url path:String,method:HTTPMethod,param:Dictionary<String,String>) -> Observable<NSData> {
        let url = NSURL(string: server_url+path)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = method.string
        var body = ""
        for key in param{
            body += (key.0 + "=\(key.1)&")
        }
        if body.hasSuffix("&"){
            body = body.substringToIndex(body.endIndex.advancedBy(-1))
        }
        print(body)
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        return NSURLSession.sharedSession().rx_data(request)
    }

    class func flatmap<O:JsonToObject where O.E == O>(data:NSData)->Observable<Array<O>>{
        return flatmap(data, deal: { (d) -> Array<O> in
            var res:Array<O> = []
            for o in d{
                res.append(O.toObject(o.1)!)
            }
            return res
        })
    }

    class func flatmap<O: JsonToObject where O.E == O>(data:NSData)->Observable<O>{
        return flatmap(data, deal: { (d) -> O in
            O.toObject(d)!
        })
    }

    class func flatmap<O>(data:NSData,deal:(d:JSON)->O)->Observable<O>{
        let json = JSON.init(data: data, options: NSJSONReadingOptions.AllowFragments, error: NSErrorPointer.init())
        print("-->HTTP Result:",json)
        let status = json.dictionaryValue["status"]?.int
        let msg = json.dictionaryValue["msg"]?.string
        return Observable.create({ (observer:AnyObserver<O>) -> Disposable in
            if(status == 1){
                let d = json.dictionaryValue["data"]
                observer.on(Event.Next(deal(d: d!)))
                observer.onCompleted()
            }else{
                observer.onError(RequestError.init(msg: msg,status: status))
            }
            return AnonymousDisposable(){}
        })
    }

}

extension API{
    class func login(phone phone:String,password:String)->Observable<UserInfo>{
        let param = ["mobile":phone,"password":password]
        return request(url:"/user/login",method:.POST, param: param)
    }
    class func register()->Observable<Array<UserInfo>>{
        return request(url: "", method: .POST, param: [:])
    }
}
