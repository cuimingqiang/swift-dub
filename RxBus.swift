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
    

    internal class func obtainEvent()->Observable<Any>{
        return subject.asObserver()
//            .flatMap({ (data:Any) -> Observable<O> in
//            return Observable.create({ (observer:AnyObserver<O>) -> Disposable in
//                if data is O.Type{
//                    observer.onNext(data as! O)
//                }
//                return NopDisposable.instance
//            })
//        })
    }
    internal class func post(event:AnyObject){
        subject.onNext(event)
    }
}