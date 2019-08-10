//
//  LinkParser.swift
//  DeclarePlus
//
//  Created by Hongyi Zheng on 2018/3/7.
//  Copyright © 2018年 Hongyi Zheng. All rights reserved.
//

import UIKit

class LinkObject: NSObject {
    
    var title: String = ""
    var iconLink: String = ""
    
    var link: String?
    
    override init() {
        super.init()
    }
    
}

class LinkParser: NSObject {

    
    class func parse(link: String, result: @escaping ((LinkObject)->())) {
        DispatchQueue.global().async {
            let resultData = LinkObject()
            resultData.link = link
            if let parsedUrl = URL.init(string: link) {
                var parsedHtmlData: Data?
                do {
                    try parsedHtmlData = Data.init(contentsOf: parsedUrl)
                } catch {
                }
                if let tmpHtmlData = parsedHtmlData {
                    if let tmpHost = parsedUrl.host {
                        if tmpHost.contains("m.weibo.cn") {
                            self.parse(weiboHtmlData: tmpHtmlData, result: { (image, title) in
                                resultData.title = title
                                resultData.iconLink = image
                            })
                        } else if parsedUrl.absoluteString.contains("music.163.com/song") {
                            // 解析title
                            self.parse(queryString: "//title", htmlData: tmpHtmlData, result: { (title) in
                                resultData.title = title
                            })
                            self.parseWangyiMusicPic(htmlData: tmpHtmlData, result: { (image) in
                                resultData.iconLink = image
                            })
                        } else if parsedUrl.absoluteString.contains("xiami.com/song") {
                            // 解析title
                            self.parse(queryString: "//title", htmlData: tmpHtmlData, result: { (title) in
                                resultData.title = title
                            })
                            // image
                            self.parseXiamiMusicPic(htmlData: tmpHtmlData, result: { (image) in
                                resultData.iconLink = image
                            })
                        } else if parsedUrl.absoluteString.contains("weixin.qq.com") {
                            self.parse(queryString: "//title", htmlData: tmpHtmlData, result: { (title) in
                                resultData.title = title
                            })
                            self.parseWeixinPic(htmlData: tmpHtmlData, result: { (image) in
                                resultData.iconLink = image
                            })
                        } else {
                            // 解析title
                            self.parse(queryString: "//title", htmlData: tmpHtmlData, result: { (title) in
                                resultData.title = title
                            })
                            // 解析image
                            self.parse(queryString: "//img", htmlData: tmpHtmlData, result: { (image) in
                                resultData.iconLink = image
                            })
                        }
                    }
                }
            }
            
            DispatchQueue.main.async {
                result(resultData)
            }
        }
    }
    
    // MARK: 微信
    fileprivate class func parseWeixinPic(htmlData: Data, result: ((String)->())) {
        let parser = TFHpple.init(htmlData: htmlData)
        let resultNodes = parser?.search(withXPathQuery: "//img")
        var resultString: String = ""
        if let tmpNodes = resultNodes as? [TFHppleElement] {
            for tmpElement in tmpNodes {
//                Log.i(tmpElement)
                if let tmpSrc = tmpElement.object(forKey: "data-src") {
                    if let srcInfo = tmpElement.object(forKey: "data-w"), let ratio = tmpElement.object(forKey: "data-ratio") {
                        if let width = Float(srcInfo), let tRatio = Float(ratio) {
                            if width >= 600 && tRatio >= 0.5 && tRatio <= 1 {
                                resultString = tmpSrc
                                break
                            }
                        }
                    }
                    
                }
            }
        }
        result(resultString)
    }
    
    // MARK: 网易云音乐
    fileprivate class func parseWangyiMusicPic(htmlData: Data, result: ((String)->())) {
        let parser = TFHpple.init(htmlData: htmlData)
        let resultNodes = parser?.search(withXPathQuery: "//img")
        var resultString: String = ""
        if let tmpNodes = resultNodes as? [TFHppleElement] {
            for tmpElement in tmpNodes {
//                Log.i(tmpElement)
                if tmpElement.object(forKey: "class") == "j-img" {
                    if let aSrc = tmpElement.object(forKey: "data-src") {
                        resultString = aSrc
                        break
                    }
                }
            }
        }
        result(resultString)
    }
    
    // MARK: 虾米音乐
    fileprivate class func parseXiamiMusicPic(htmlData: Data, result: ((String)->())) {
        let parser = TFHpple.init(htmlData: htmlData)
        let resultNodes = parser?.search(withXPathQuery: "//meta")
        var resultString: String = ""
        if let tmpNodes = resultNodes as? [TFHppleElement] {
            for tmpElement in tmpNodes {
                if tmpElement.object(forKey: "property") == "og:image" {
                    resultString = tmpElement.object(forKey: "content")
                    break
                }
            }
        }
        result(resultString)
    }
    
    // MARK: 微博
    fileprivate class func parse(weiboHtmlData: Data, result: ((String, String)->())) {
        let parser = TFHpple.init(htmlData: weiboHtmlData)
        let resultNodes = parser?.search(withXPathQuery: "//script")
        var resultAvatar = ""
        var resultContent = ""
        if let tmpNodes = resultNodes as? [TFHppleElement] {
            for element in tmpNodes {
//                Log.i("-------------")
                if element.object(forKey: "type") == nil {
                    if element.firstChild != nil {
                        let array = element.firstChild.content.components(separatedBy: "user\":")
                        if array.count >= 2 {
                            resultAvatar = self.loadWeiboMoblieImage(content: element.firstChild.content)
                            resultContent = self.loadWeiboMobileContent(content: element.firstChild.content)
                            break
                        }
                    }
                }
            }
        }
        result(resultAvatar, resultContent)
    }
    
    fileprivate class func loadWeiboMoblieImage(content: String) -> String {
        var result = ""
        let array = content.components(separatedBy: "user\":")
        if array.count >= 2 {
            let tmpArray = array[1].components(separatedBy: "},")
            let tmpJsonStr = tmpArray[0] + "}"
            var tmpDic: [String: Any]?
            if let tmpData = tmpJsonStr.data(using: .utf8) {
                do {
                    try tmpDic = JSONSerialization.jsonObject(with: tmpData, options: []) as? [String: Any]
                } catch {}
            }
            if let tmpInfo = tmpDic {
                if let hdImage = tmpInfo["avatar_hd"] as? String {
                    result = hdImage
                } else if let smallImage = tmpInfo["profile_image_url"] as? String {
                    result = smallImage
                }
            }
        }
        return result
    }
    
    fileprivate class func loadWeiboMobileContent(content: String) -> String {
        var result = ""
        let array = content.components(separatedBy: "page_info")
        if array.count >= 2 {
            let tmpArray = array[1].components(separatedBy: "content2\":")
            if tmpArray.count >= 2 {
                let tmpResultArray = tmpArray[1].components(separatedBy: "\",")
                let tmpResult = tmpResultArray[0]
                result = String(tmpResult.suffix(tmpResult.count - 2))
            }
        }
        return result
    }
    
    // MARK: 通用
    fileprivate class func parse(queryString: String, htmlData: Data, result: ((String)->())) {
        let parser = TFHpple.init(htmlData: htmlData)
        let query = queryString
        let resultNodes = parser?.search(withXPathQuery: query)
        
        var resultString: String = ""
        
        if let tmpNodes = resultNodes as? [TFHppleElement] {
            for tmpElement in tmpNodes {
                if query == "//title" {
                    if tmpElement.firstChild != nil {
                        if let tmpTitle = tmpElement.firstChild.content {
                            resultString = tmpTitle
                            break
                        }
                    }
                } else if query == "//img" {
                    if let tmpSrc = tmpElement.object(forKey: "src"), let tmpWidth = tmpElement.object(forKey: "width"), let tmpHeight = tmpElement.object(forKey: "height") {
                        if let width = Int(tmpWidth), let height = Int(tmpHeight) {
                            if width >= 300 && height >= 300 {
                                resultString = tmpSrc
                                break
                            }
                        }
                    }
                }
            }
        }
        result(resultString)
    }
}
