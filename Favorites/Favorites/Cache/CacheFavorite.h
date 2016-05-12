//
//  CacheFavorite.h
//  Favorites
//
//  Created by Hongyi Zheng on 16/5/12.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

#import "CacheBase.h"

@interface CacheFavorite : CacheBase

- (void) cacheFavorite:(id) favorite forCategory:(NSString *) category;

- (id) loadCachedFavoritesForCategory:(NSString *) category;

@end
