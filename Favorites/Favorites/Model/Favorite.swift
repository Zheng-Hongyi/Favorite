//
//  Favorite.swift
//  Favorites
//
//  Created by 洪毅 郑 on 16/3/6.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

import UIKit

struct PropertyKey {
    static let nameKey = "name"
    static let sourceKey = "source"
}

class Favorite: NSObject, NSCoding {
    var name: String
    var source: String
    
    init(name: String, source: String) {
        self.name = name
        self.source = source
        
        super.init()
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(source, forKey: PropertyKey.sourceKey)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name_ = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let source_ = aDecoder.decodeObjectForKey(PropertyKey.sourceKey) as! String
        self.init(name:name_,source:source_);
    }

}
