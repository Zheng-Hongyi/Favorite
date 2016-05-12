//
//  CacheFavorite.m
//  Favorites
//
//  Created by Hongyi Zheng on 16/5/12.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

#import "CacheFavorite.h"

static NSString *const kCacheFavorite = @"k_app_cache_favorites";

@implementation CacheFavorite

- (void) cacheFavorite:(id)favorite forCategory:(NSString *)category {
    NSArray *cachedData = [self loadCachedFavoritesForCategory:category];
    NSMutableArray *willCachedData;
    if (nil == cachedData || cachedData.count == 0) {
        willCachedData = [NSMutableArray new];
    } else {
        willCachedData = [[NSMutableArray alloc] initWithArray:cachedData];
    }
    [willCachedData addObject:favorite];
    [self cacheObjectData:willCachedData forKey:[NSString stringWithFormat:@"%@%@",kCacheFavorite,category]];

}

- (id) loadCachedFavoritesForCategory:(NSString *)category {
    return [self loadCachedObjectDataForKey:[NSString stringWithFormat:@"%@%@",kCacheFavorite,category]];
}

@end
