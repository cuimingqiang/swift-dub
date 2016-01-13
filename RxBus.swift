//
//  RxBus.swift
//  dub
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 cuimingqiang. All rights reserved.
//

import Foundation
import RxSwift
class RxBus {
    private static var subject = PublishSubject<Any>.init()
    

    internal class func obtainEvent<E>()->Observable<E>{
        return subject.asObserver()
            .filter({ $0 is E})
            .map({ $0 as! E })
    }
    internal class func post(event:AnyObject){
        subject.onNext(event)
    }
}