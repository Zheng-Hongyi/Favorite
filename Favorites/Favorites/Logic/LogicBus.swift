//
//  LogicBus.swift
//  Favorites
//
//  Created by Hongyi Zheng on 16/5/14.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

import Foundation

class LogicBus: NSObject {
    
    var homeLogic: HomeLogic
    var groupDetail: GroupDetailLogic
    
    override init() {
        homeLogic = HomeLogic();
        groupDetail = GroupDetailLogic();
        super.init();
    }
    
    class var sharedInstance: LogicBus {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: LogicBus? = nil
        }
        dispatch_once(&Static.onceToken) { () -> Void in
            Static.instance = LogicBus();
        }
        return Static.instance!

    }
}
