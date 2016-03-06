//
//  CacheBus.swift
//  Favorites
//
//  Created by 洪毅 郑 on 16/3/6.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

import UIKit
class CacheBus: NSObject {
    
    var favorite: CacheFavorite
    var favoriteCategory: CacheCategory
    
    override init() {
        favorite = CacheFavorite();
        favoriteCategory = CacheCategory();
        super.init()
    }
    
    class var sharedInstance: CacheBus {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: CacheBus? = nil
        }
        dispatch_once(&Static.onceToken) { () -> Void in
            Static.instance = CacheBus();
        }
        return Static.instance!
    }

}
