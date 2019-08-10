//
//  Utils.swift
//  Favorites
//
//  Created by Yi on 2019/8/10.
//  Copyright © 2019 洪毅 郑. All rights reserved.
//

import UIKit

class Utils: NSObject {

    class func detectUrl(input: String) -> String {
        var result = ""
        let detector = try! NSDataDetector.init(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: input, options: [], range: NSRange.init(location: 0, length: input.utf16.count))
        for match in matches {
            guard let range = Range(match.range, in: input) else { continue }
            let url = input[range]
            result = String(url)
        }
        return result
        
    }
}
