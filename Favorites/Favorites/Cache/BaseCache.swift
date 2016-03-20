//
//  BaseCache.swift
//  Favorites
//
//  Created by 洪毅 郑 on 16/3/6.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

import UIKit

class BaseCache: NSObject {
    // MARK: Archiving Paths
    var cacheDirectiory = "/Library/Caches/favorite/1/"
    
    func cacheObjects(source:AnyObject!,cacheKey:String) {
        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            let fileFullPath = self.generateFileInDir(self.cacheDirectiory, fileName: cacheKey)
            let isSuccess = NSKeyedArchiver.archiveRootObject(source, toFile: fileFullPath)
            print(source)
            print(fileFullPath)
            if !isSuccess {
                print("failed")
            }
        }
    }
    
    func loadCachedObjectsForKey(cacheKey:String) ->AnyObject {
        let fileFullPath = self.generateFileInDir(self.cacheDirectiory, fileName: cacheKey)
        return NSKeyedUnarchiver.unarchiveObjectWithFile(fileFullPath)!
    }
    
    
    internal func generateFileInDir(dir:String,fileName:String) ->String {
        let manager = NSFileManager.defaultManager();
//        let tmp = manager.URLsForDirectory(NSSearchPathDirectory.ApplicationSupportDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).first
        //let urlsForLibrary = tmp! as NSURL
        let urlsForLibrary = NSHomeDirectory();
        let folder = urlsForLibrary + cacheDirectiory;
        let hasDirectory = manager.fileExistsAtPath(folder)
        if !hasDirectory {
            do {
                try manager.createDirectoryAtPath(folder, withIntermediateDirectories: false, attributes: nil)
            } catch {
            
            }
        }
        return folder + fileName;
    }

}
