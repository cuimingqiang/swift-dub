//
//  RequestError.swift
//  dub
//
//  Created by cuimingqiang on 16/1/7.
//  Copyright © 2016年 cuimingqiang. All rights reserved.
//

import Foundation
import RxCocoa
class RequestError: ErrorType {
    var msg:String? = nil
    var status:Int? = 0
    init(msg:String?,status:Int?){
        self.msg = msg
        self.status = status
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