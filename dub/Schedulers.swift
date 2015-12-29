//
//  Schedulers.swift
//  dub
//
//  Created by cuimingqiang on 15/12/22.
//  Copyright © 2015年 cuimingqiang. All rights reserved.
//

import Foundation
#if !RX_NO_MODULE
    import RxSwift
#endif
class Schedulers {
    private static let sharedDependencies = Schedulers() // Singleton
    private let backgroundWorkScheduler: ImmediateSchedulerType
    private let mainScheduler: SerialDispatchQueueScheduler


    class func IO()-> ImmediateSchedulerType{
        return sharedDependencies.backgroundWorkScheduler
    }

    class func MainScheduler()-> ImmediateSchedulerType{
        return sharedDependencies.mainScheduler
    }

    private init() {

        let operationQueue = NSOperationQueue()
        operationQueue.maxConcurrentOperationCount = 2
        #if !RX_NO_MODULE
            operationQueue.qualityOfService = NSQualityOfService.UserInitiated
        #endif
        backgroundWorkScheduler = OperationQueueScheduler(operationQueue: operationQueue)
        mainScheduler = MainScheduler.sharedInstance
    }
}