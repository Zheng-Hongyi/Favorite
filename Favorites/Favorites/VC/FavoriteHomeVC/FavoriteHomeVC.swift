//
//  FavoriteHomeVC.swift
//  Favorites
//
//  Created by 洪毅 郑 on 16/2/21.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

import UIKit

class FavoriteHomeVC: BaseTVC {
    
    var groupNames = [FavoriteCategory]()
    
    let userKey = "addmin"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "首页";
        loadGroupNames();
        configView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Private methods
    func loadGroupNames () {
        if let tmpGroupNames =  CacheBus.ins().category.loadCachedCategoriesForKey(userKey) {
            groupNames = tmpGroupNames as! [FavoriteCategory];
        } else {
            print("error")
        }
    }
    
    func configView () {
        tableView.tableFooterView = UIView.init();
    }
    
    @IBAction func addFavoriteCategory(sender: AnyObject) {
        print("hello world")
        let alert:UIAlertView = UIAlertView(title: "Alert", message: "I'm an iOS7 alert", delegate: self, cancelButtonTitle: "OK")
        alert.delegate = self
        alert.show()
    }
   
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupNames.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "GroupCell";
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GroupCell;
        let groupName = groupNames[indexPath.row];
        cell.groupNameLabel.text = groupName.categoryName;
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    @IBAction func unwindToHomeList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddFavoriteCategoryVC, needAddedCategory = sourceViewController.currentCategory {
            groupNames.append(needAddedCategory)
            tableView.reloadData()
            CacheBus.ins().category.cacheCategories(needAddedCategory, forKey: userKey)
            //CacheBus.sharedInstance.favoriteCategory.cacheFavoriteCategories(groupNames, cacheKey: userKey)
            
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDetailGroup" {
            let groupDetailViewController = segue.destinationViewController as! FavoriteGroupDetailVC
            if let selectedCell = sender as? GroupCell {
                let indexPath = tableView.indexPathForCell(selectedCell)!
                let selectedCategory = groupNames[indexPath.row]
                groupDetailViewController.currentGropCategory = selectedCategory
            }
        
        } else if segue.identifier == "AddGroup" {
            
        }
    }


}
