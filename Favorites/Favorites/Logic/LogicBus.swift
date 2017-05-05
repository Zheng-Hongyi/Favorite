//
//  LogicBus.swift
//  Favorites
//
//  Created by Hongyi Zheng on 16/5/14.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

import Foundation

struct Static {
    static var onceToken: Int = 0
    static var instance: LogicBus? = nil
}

class LogicBus: NSObject {
    
    private static var __once: () = { () -> Void in
            Static.instance = LogicBus();
        }()
    
    var homeLogic: HomeLogic
    var groupDetail: GroupDetailLogic
    
    override init() {
        homeLogic = HomeLogic();
        groupDetail = GroupDetailLogic();
        super.init();
    }
    
    class var sharedInstance: LogicBus {
        _ = LogicBus.__once
        return Static.instance!

    }
}
