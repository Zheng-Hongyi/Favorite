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
    var groupDetails = [Favorite]();

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = currentGropCategory?.categoryName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func unwindToDetailList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddFavoriteItemVC, needAddedCategory = sourceViewController.currentItem {
            groupDetails.append(needAddedCategory)
            tableView.reloadData()
            
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
