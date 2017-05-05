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
    func encode(with aCoder: NSCoder) {
        aCoder.encode(categoryName, forKey: FCPropertyKey.categoryName)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name_ = aDecoder.decodeObject(forKey: FCPropertyKey.categoryName) as! String
        self.init(tmpName: name_);
    }

}
