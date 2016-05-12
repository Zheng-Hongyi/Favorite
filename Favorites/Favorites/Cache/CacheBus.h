//
//  CacheBus.h
//  Favorites
//
//  Created by Hongyi Zheng on 16/5/12.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CacheCategory.h"
#import "CacheFavorite.h"

@interface CacheBus : NSObject

@property (nonatomic, strong) CacheCategory *category;
@property (nonatomic, strong) CacheFavorite *favorite;


+ (instancetype) ins;

@end
