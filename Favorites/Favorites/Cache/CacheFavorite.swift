//
//  CacheFavorite.swift
//  Favorites
//
//  Created by 洪毅 郑 on 16/3/6.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

import UIKit

class CacheFavorite: BaseCache {
    
    func cacheFavorites(favorites:[Favorite],groupName:String) {
        self.cacheObjects(favorites, cacheKey: groupName)
    }
    
    func loadCachedFavoritesForKey(cacheKey:String) -> AnyObject {
        return self.loadCachedObjectsForKey(cacheKey)
    }

}
