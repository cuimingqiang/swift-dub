//
//  Result.swift
//  dub
//
//  Created by cuimingqiang on 15/12/28.
//  Copyright © 2015年 cuimingqiang. All rights reserved.
//

import Foundation
class Result<JsonToObject>{
    typealias E = JsonToObject
    var status :Int = 0
    var msg : String?
    var data : E?
}