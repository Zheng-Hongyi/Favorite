//
//  FavoriteGroupDetailVC.swift
//  Favorites
//
//  Created by 洪毅 郑 on 16/3/6.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

import UIKit

class FavoriteGroupDetailVC: BaseTVC {
    
    var currentGropCategory : FavoriteCategory?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = currentGropCategory?.categoryName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func unwindToHomeList(sender: UIStoryboardSegue) {
//        if let sourceViewController = sender.sourceViewController as? AddFavoriteCategoryVC, needAddedCategory = sourceViewController.currentCategory {
//            groupNames.append(needAddedCategory)
//            tableView.reloadData()
//            
//        }
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
