//
//  FavoriteCategory.swift
//  Favorites
//
//  Created by 洪毅 郑 on 16/3/6.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

import UIKit

struct FCPropertyKey {
    static let categoryName = "categoryName"
}

class FavoriteCategory: NSObject, NSCoding {
    
    var categoryName: String;
    
    init(tmpName:String) {
        self.categoryName = tmpName;
        super.init()
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(categoryName, forKey: FCPropertyKey.categoryName)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name_ = aDecoder.decodeObjectForKey(FCPropertyKey.categoryName) as! String
        self.init(tmpName: name_);
    }

}
