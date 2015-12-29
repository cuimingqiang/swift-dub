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
    class func login(phone phone:String,password:String)->Observable<Result<UserInfo>>{
        print(phone,password)
        let url = NSURL(string: server_url+"/user/login")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        let body:String = String.init(format: "mobile=\(phone)&password=\(password)&devicetoken='333333'")
        print(body)
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        print(request.description)
        return NSURLSession.sharedSession().rx_data(request).map({ (data) -> Result<UserInfo> in
            let result = Result<UserInfo>()
            let json = JSON.init(data: data, options: NSJSONReadingOptions.AllowFragments, error: NSErrorPointer.init())
            print(json)
            result.status = (json.dictionaryValue["status"]?.int)!
            result.msg = json.dictionaryValue["msg"]?.string
            
            result.data = UserInfo.toObject(json.dictionaryValue["data"])
            print(result.status)
            return result
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