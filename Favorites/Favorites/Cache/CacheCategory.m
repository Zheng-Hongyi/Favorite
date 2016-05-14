//
//  CacheCategory.m
//  Favorites
//
//  Created by Hongyi Zheng on 16/5/12.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

#import "CacheCategory.h"

static NSString *const kCacheCategory = @"k_app_cache_category";

@implementation CacheCategory

- (void) cacheCategories:(id) gategory forKey:(NSString *) userId {
    NSArray *cachedData = [self loadCachedCategoriesForKey:userId];
    NSMutableArray *willCachedData;
    if (nil == cachedData || cachedData.count == 0) {
        willCachedData = [NSMutableArray new];
    } else {
        willCachedData = [[NSMutableArray alloc] initWithArray:cachedData];
    }
    [willCachedData addObject:gategory];
    [self cacheObjectData:willCachedData forKey:[NSString stringWithFormat:@"%@%@",kCacheCategory,userId]];
}

- (void) cacheAllCategories:(id)all forKey:(NSString *)userId {
    [self cacheObjectData:all forKey:[NSString stringWithFormat:@"%@%@",kCacheCategory,userId]];
}

- (id) loadCachedCategoriesForKey:(NSString *) userId {
    return [self loadCachedObjectDataForKey:[NSString stringWithFormat:@"%@%@",kCacheCategory,userId]];
}

@end
