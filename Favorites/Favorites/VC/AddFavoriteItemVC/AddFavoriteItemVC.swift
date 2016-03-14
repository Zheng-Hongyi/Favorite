//
//  AddFavoriteItemVC.swift
//  Favorites
//
//  Created by 洪毅 郑 on 16/3/13.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

import UIKit

class AddFavoriteItemVC: BaseVC {

    @IBOutlet weak var itemLInkTextFiled: UITextField!
    @IBOutlet weak var itemNameTextFiled: UITextField!
    
    var currentItem : Favorite?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelAction(sender: AnyObject) {
        dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
