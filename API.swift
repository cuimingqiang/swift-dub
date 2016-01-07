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
class API{
    static let server_url = "https://childapitest.qupeiyin.com"
    class func login(phone phone:String,password:String)->Observable<UserInfo>{

        let url = NSURL(string: server_url+"/user/login")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        let body:String = String.init(format: "mobile=\(phone)&password=\(password)&devicetoken='333333'")
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        return NSURLSession.sharedSession().rx_data(request)
            .flatMap({ (data) -> Observable<UserInfo> in
               return flatmap(data)
            })
//            .map({ (data) -> Result<UserInfo> in
//            let result = Result<UserInfo>()
//            let json = JSON.init(data: data, options: NSJSONReadingOptions.AllowFragments, error: NSErrorPointer.init())
//            print(json)
//            result.status = (json.dictionaryValue["status"]?.int)!
//            result.msg = json.dictionaryValue["msg"]?.string
//            
//            result.data = UserInfo.toObject(json.dictionaryValue["data"])
//            print(result.status)
//            return result
//        })
    }

    class func post(url:String,param:Dictionary<String,String>){
        
    }

    class func flatmap<O: JsonToObject where O.E == O>(data:NSData)->Observable<O>{
        let json = JSON.init(data: data, options: NSJSONReadingOptions.AllowFragments, error: NSErrorPointer.init())
        let status = json.dictionaryValue["status"]?.int
        let msg = json.dictionaryValue["msg"]?.string
        return create({ (observer:AnyObserver<O>) -> Disposable in
            if(status==1){
                let o = O.toObject(json.dictionaryValue["data"])
                observer.on(Event.Next(o!))
                observer.onCompleted()
            }else{
                observer.onError(RequestError.init(msg: msg,status: status))
            }
            return AnonymousDisposable(){}
        })
    }
}

extension RxCocoaURLError{
    public var code : Int{
        switch self{
        case .Unknown:
            return -1
        case .NonHTTPResponse(_):
            return -3
        case let .HTTPRequestFailed(response,_):
            return response.statusCode
        case .DeserializationError(_):
            return -2
        }
    }
    public var message :String{
        switch self{
        case .Unknown:
            return "未知错误"
        case .NonHTTPResponse(_):
            return "非法响应"
        case let .HTTPRequestFailed(response,_):
            print(response)
            return response.URL.debugDescription
        case .DeserializationError(_):
            return "解析错误"
        }
    }
}