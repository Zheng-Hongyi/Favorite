//
//  CacheBase.h
//  Favorites
//
//  Created by Hongyi Zheng on 16/5/12.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kCacheDir = @"Library/caches/keep";
static const int kCacheVersion = 1;

@interface CacheBase : NSObject

- (void) cacheObjectData:(id) data forKey:(NSString *) cacheKey;

- (void) cacheObjectData:(id)data forKey:(NSString *)cacheKey result:(void (^)(BOOL success)) result;

- (id) loadCachedObjectDataForKey:(NSString *) cacheKey;

- (void) clearCachedDataForKey:(NSString *) cacheKey;

- (void) clearCachedDataForKey:(NSString *)cacheKey result:(void (^)(BOOL success)) result;

@end
