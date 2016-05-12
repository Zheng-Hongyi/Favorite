//
//  CacheCategory.h
//  Favorites
//
//  Created by Hongyi Zheng on 16/5/12.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

#import "CacheBase.h"

@interface CacheCategory : CacheBase

- (void) cacheCategories:(id) gategory forKey:(NSString *) userId;

- (id) loadCachedCategoriesForKey:(NSString *) userId;

@end
