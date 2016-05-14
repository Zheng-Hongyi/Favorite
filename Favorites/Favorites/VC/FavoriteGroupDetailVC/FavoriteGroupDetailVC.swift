//
//  FavoriteGroupDetailVC.swift
//  Favorites
//
//  Created by 洪毅 郑 on 16/3/6.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

import UIKit

class FavoriteGroupDetailVC: BaseTVC, HYNoResultsViewDelegate, UIAlertViewDelegate {
    
    var currentGropCategory : FavoriteCategory?
    var groupDetails = [Favorite]();
    var noResultView:HYNoResultsView?
    var needDeleteIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = currentGropCategory?.categoryName
        configView()
        self.loadDatas()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func unwindToDetailList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddFavoriteItemVC, needAddedCategory = sourceViewController.currentItem {
            groupDetails.append(needAddedCategory)
            refreshView()
            CacheBus.ins().favorite.cacheFavorite(needAddedCategory, forCategory: currentGropCategory?.categoryName)
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupDetails.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "FavoriteCell";
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! FavoriteCell;
        let groupName = groupDetails[indexPath.row];
        cell.favoriteNameLabel.text = groupName.name;
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            let alert:UIAlertView = UIAlertView(title: "", message: "确定要删除吗", delegate: self, cancelButtonTitle: "取消" )
            alert.addButtonWithTitle("删除")
            alert.delegate = self
            alert.show()
            alert.tag = 100
            needDeleteIndex = indexPath.row;
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // MARK: UIAlertViewDelegate
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 100 {
            if 0 == buttonIndex {
                refreshView()
            }
            if 1 == buttonIndex {
                let tmp = groupDetails[needDeleteIndex!]
                LogicBus.sharedInstance.groupDetail.remove(tmp, index: needDeleteIndex!, categoryName: (currentGropCategory?.categoryName)!)
                groupDetails.removeAtIndex(needDeleteIndex!)
                refreshView()
            }
        }
    }



    // MARK: - Private methods
    
    func loadDatas() {
        if let tmpDetails = CacheBus.ins().favorite.loadCachedFavoritesForCategory(currentGropCategory?.categoryName) {
            groupDetails = tmpDetails as! [Favorite]
        }
        refreshView()
    }
    
    func configView () {
        noResultView = HYNoResultsView.init(title: "没有添加任何内容", message: "您可以在这里添加您喜欢的文章标题以及对应的链接", accessoryView: nil, buttonTitle: "添加")
        noResultView?.delegate = self
        tableView.tableFooterView = UIView.init();
    }
    
    func refreshView () {
        if 0 == groupDetails.count {
            tableView.addSubview(noResultView!)
        } else {
            noResultView?.removeFromSuperview()
        }
        tableView.reloadData()
    }
    
    // MARK: - HYNoResultViewDelegate
    
    func didTapNoResultsView(noResultsView: HYNoResultsView!) {
        //addFavoriteCategory(0)
        self.performSegueWithIdentifier("AddFavoriteItem", sender: 0)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "enterFavoriteDetail" {
            let fvoriteDetailVC = segue.destinationViewController as! FavoriteDetailVC;
            if let selectedCell = sender as? FavoriteCell {
                let indexPath = tableView.indexPathForCell(selectedCell)!
                let selectedFavorite = groupDetails[indexPath.row]
                fvoriteDetailVC.currentFavorite = selectedFavorite
            }
        }
    }
    

}
