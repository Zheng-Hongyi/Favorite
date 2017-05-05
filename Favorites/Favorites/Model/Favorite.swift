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
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(source, forKey: PropertyKey.sourceKey)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name_ = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let source_ = aDecoder.decodeObject(forKey: PropertyKey.sourceKey) as! String
        self.init(name:name_,source:source_);
    }

}
