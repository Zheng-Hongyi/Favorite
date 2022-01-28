//
//  FavoriteDetailVC.swift
//  Favorites
//
//  Created by Hongyi Zheng on 16/3/19.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

import UIKit
import WebKit

class FavoriteDetailVC: BaseVC, WKNavigationDelegate {

    @IBOutlet weak var mainWeb: WKWebView!
    @IBOutlet weak var goButton: UIButton!
    var currentFavorite : Favorite?
    
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.isEnabled = false
        goButton.isEnabled = false
        backButton.tintColor = .blue
        goButton.tintColor = .blue
        mainWeb.navigationDelegate = self

        // Do any additional setup after loading the view.
        self.title = currentFavorite!.name;
        //let url = NSURLRequest.init(URL: NSURL.init(string: currentFavorite!.source)!)
        let url = URLRequest.init(url: URL.init(string: currentFavorite!.source)!, cachePolicy: NSURLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 60*60*24*7)
        mainWeb.load(url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backAction(_ sender: Any) {
        if mainWeb.canGoBack {
            mainWeb.goBack()
        }
    }
    
    @IBAction func goAction(_ sender: Any) {
        if mainWeb.canGoForward {
            mainWeb.goForward()
        }
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = webView.canGoBack
        goButton.isEnabled = webView.canGoForward
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
