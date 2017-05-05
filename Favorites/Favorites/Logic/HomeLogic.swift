//
//  HomeLogic.swift
//  Favorites
//
//  Created by Hongyi Zheng on 16/5/14.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

import Foundation

class HomeLogic: NSObject {
    
    func remove(_ cateGory:FavoriteCategory,index:Int, userKey:String) -> Bool {
        // 需要操作两个缓存 1、移除category 2、移除category下的具体内容
        CacheBus.ins().favorite.clearCachedFavorite(forCategory: cateGory.categoryName)
        if let tmpGroupNames =  CacheBus.ins().category.loadCachedCategories(forKey: userKey) {
            var groupNames = tmpGroupNames as! [FavoriteCategory];
            groupNames.remove(at: index)
            CacheBus.ins().category.cacheAllCategories(groupNames, forKey: userKey)
        }
        return false;
    }
    
    
}
