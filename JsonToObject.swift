//
//  JsonToObject.swift
//  dub
//
//  Created by cuimingqiang on 15/12/28.
//  Copyright © 2015年 cuimingqiang. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol JsonToObject{
    typealias E
    static func toObject(json:JSON?)->E?
}