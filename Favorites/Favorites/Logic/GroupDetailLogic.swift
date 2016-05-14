//
//  GroupDetailLogic.swift
//  Favorites
//
//  Created by Hongyi Zheng on 16/5/14.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

import Foundation

class GroupDetailLogic: NSObject {
    func remove(favorite:Favorite,index:Int, categoryName:String) -> Bool {
        //
        if let tmpAllFavorites =  CacheBus.ins().favorite.loadCachedFavoritesForCategory(categoryName) {
            var allFavorites = tmpAllFavorites as! [Favorite];
            allFavorites.removeAtIndex(index)
            CacheBus.ins().favorite.cacheAllFavorites(allFavorites, forCategory: categoryName)
        }
        return false;
    }
}
