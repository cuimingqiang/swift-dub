//
//  ResultSubscriber.swift
//  dub
//
//  Created by cuimingqiang on 16/1/8.
//  Copyright © 2016年 cuimingqiang. All rights reserved.
//

import Foundation
import RxSwift

class ResultSubscribe<T>: ObserverType {
    func on(event: Event<T>) {
        switch event{
        case let .Error(e):
            print(e)
        case let .Next(data):

            print(data)
        case .Completed:
            print("completed")
        }
    }
}
