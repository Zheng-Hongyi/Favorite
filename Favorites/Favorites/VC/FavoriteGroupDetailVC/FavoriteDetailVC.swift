//
//  FavoriteDetailVC.swift
//  Favorites
//
//  Created by Hongyi Zheng on 16/3/19.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

import UIKit

class FavoriteDetailVC: BaseVC {

    @IBOutlet weak var mainWeb: UIWebView!
    var currentFavorite : Favorite?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = currentFavorite!.name;
        let url = NSURLRequest.init(URL: NSURL.init(string: currentFavorite!.source)!)
        mainWeb.loadRequest(url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
