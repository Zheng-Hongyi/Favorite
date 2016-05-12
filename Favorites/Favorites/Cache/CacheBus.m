//
//  CacheBus.m
//  Favorites
//
//  Created by Hongyi Zheng on 16/5/12.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

#import "CacheBus.h"

@implementation CacheBus

+ (instancetype) ins {
    static CacheBus *cacheBus = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cacheBus = [[super allocWithZone:NULL] init];
    });
    return cacheBus;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        _category = [CacheCategory new];
        _favorite = [CacheFavorite new];
    }
    return self;
}

@end
