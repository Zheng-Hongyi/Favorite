//
//  CacheCategory.swift
//  Favorites
//
//  Created by 洪毅 郑 on 16/3/6.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

import UIKit

class CacheCategory: BaseCache {
    
    func cacheFavoriteCategories(categories:[FavoriteCategory],cacheKey:String) {
        self.cacheObjects(categories, cacheKey: cacheKey)
    }
    
    func loadCachedFavoriteCategoriesForKey(cacheKey:String) -> AnyObject {
        return self.loadCachedObjectsForKey(cacheKey)
    }
}
