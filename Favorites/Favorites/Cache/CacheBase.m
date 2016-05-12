//
//  CacheBase.m
//  Favorites
//
//  Created by Hongyi Zheng on 16/5/12.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

#import "CacheBase.h"
#import "kDefine.h"

@implementation CacheBase

- (void) cacheObjectData:(id)data forKey:(NSString *)cacheKey {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *cache = kCacheDir;
        NSString *draftPath = [self generateFileInDir:[NSString stringWithFormat:@"%@/%d",cache,kCacheVersion] fileName:cacheKey];
        NSData *archiveCarPriceData = [NSKeyedArchiver archivedDataWithRootObject:data];
        if ([archiveCarPriceData writeToFile:draftPath atomically:YES]) {
            DLog(@"write success!");
            DLog(@"draftPath--> %@",draftPath);
        } else {
            DLog(@"failed");
        }
    });
}

- (void) cacheObjectData:(id)data forKey:(NSString *)cacheKey result:(void (^)(BOOL))result {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *cache = kCacheDir;
        NSString *draftPath = [self generateFileInDir:[NSString stringWithFormat:@"%@/%d",cache,kCacheVersion] fileName:cacheKey];
        NSData *archiveCarPriceData = [NSKeyedArchiver archivedDataWithRootObject:data];
        if ([archiveCarPriceData writeToFile:draftPath atomically:YES]) {
            DLog(@"write success!");
            DLog(@"draftPath--> %@",draftPath);
            dispatch_async(dispatch_get_main_queue(), ^{
                result(YES);
            });
        } else {
            DLog(@"failed");
            dispatch_async(dispatch_get_main_queue(), ^{
                result(NO);
            });
        }
    });
}

- (void) cacheObjectDataSync:(id)data forKey:(NSString *)cacheKey{
    NSString *cache = kCacheDir;
    NSString *draftPath = [self generateFileInDir:[NSString stringWithFormat:@"%@/%d",cache,kCacheVersion] fileName:cacheKey];
    NSData *archiveCarPriceData = [NSKeyedArchiver archivedDataWithRootObject:data];
    if ([archiveCarPriceData writeToFile:draftPath atomically:YES]) {
        DLog(@"write success!");
        DLog(@"draftPath--> %@",draftPath);
    } else {
        DLog(@"failed");
    }
}

- (id) loadCachedObjectDataForKey:(NSString *)cacheKey {
    NSString *cache = kCacheDir;
    NSString *draftPath = [self generateFileInDir:[NSString stringWithFormat:@"%@/%d",cache,kCacheVersion] fileName:cacheKey];
    NSData *archiveData = [NSData dataWithContentsOfFile:draftPath];
    if (archiveData) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:archiveData];
    }
    return nil;
}

- (void) clearCachedDataForKey:(NSString *)cacheKey {
    NSString *cache = kCacheDir;
    NSString *draftPath = [self generateFileInDir:[NSString stringWithFormat:@"%@/%d",cache,kCacheVersion] fileName:cacheKey];
    NSError *error = nil;
    if ([[NSFileManager defaultManager] removeItemAtPath:draftPath error:&error]) {
        DLog(@"清楚成功");
    } else
        DLog(@"%@",error.description);
}

- (void) clearCachedDataForKey:(NSString *)cacheKey result:(void (^)(BOOL))result {
    NSString *cache = kCacheDir;
    NSString *draftPath = [self generateFileInDir:[NSString stringWithFormat:@"%@/%d",cache,kCacheVersion] fileName:cacheKey];
    NSError *error = nil;
    if ([[NSFileManager defaultManager] removeItemAtPath:draftPath error:&error]) {
        if (result) {
            result(YES);
        }
    } else
        DLog(@"%@",error.description);
}


#pragma mark - private methods

- (NSString *) generateFileInDir:(NSString *)dir fileName:(NSString *)fname
{
    //    NSString *urlString = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:kAWAppGroupName].path;
    //    NSString *fileDirectory = [urlString stringByAppendingPathComponent:dir];
    NSString *fileDirectory = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",dir]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:fileDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *path;
    path = [NSString stringWithFormat:@"%@/%@",fileDirectory,fname];
    return path;
}

@end
