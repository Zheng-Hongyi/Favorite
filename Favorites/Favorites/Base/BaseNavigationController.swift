//
//  BaseNavigationController.swift
//  Favorites
//
//  Created by 洪毅 郑 on 16/2/21.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let aColor = UIColor.init(named: "color_text") {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowImage = nil
            appearance.shadowColor = UIColor.clear
            appearance.titleTextAttributes = [.foregroundColor: aColor, .font: UIFont.boldSystemFont(ofSize: 20)]
            self.navigationBar.standardAppearance = appearance
            self.navigationBar.scrollEdgeAppearance = self.navigationBar.standardAppearance
            self.navigationBar.barTintColor = aColor
            self.navigationBar.tintColor = aColor
            
//            let tbAppearance = UIToolbarAppearance()
//            tbAppearance.configureWithOpaqueBackground()
//            tbAppearance.shadowImage = nil
//            tbAppearance.shadowColor = .white
//            self.toolbar.standardAppearance = tbAppearance
//            if #available(iOS 15.0, *) {
//                self.toolbar.scrollEdgeAppearance = self.toolbar.standardAppearance
//            } else {
//                // Fallback on earlier versions
//            }
        }
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
