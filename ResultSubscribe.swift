//
//  ResultSubscipt.swift
//  dub
//
//  Created by cuimingqiang on 15/12/28.
//  Copyright © 2015年 cuimingqiang. All rights reserved.
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