//
//  RequestError.swift
//  dub
//
//  Created by cuimingqiang on 16/1/7.
//  Copyright © 2016年 cuimingqiang. All rights reserved.
//

import Foundation
class RequestError: ErrorType {
    var msg:String? = nil
    var status:Int? = 0
    init(msg:String?,status:Int?){
        self.msg = msg
        self.status = status
    }
}