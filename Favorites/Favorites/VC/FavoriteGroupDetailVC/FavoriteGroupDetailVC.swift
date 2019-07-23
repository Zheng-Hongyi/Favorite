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
    
    
    @IBAction func unwindToDetailList(_ sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddFavoriteItemVC, let needAddedCategory = sourceViewController.currentItem {
            groupDetails.append(needAddedCategory)
            refreshView()
            CacheBus.ins().favorite.cacheFavorite(needAddedCategory, forCategory: currentGropCategory?.categoryName)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupDetails.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FavoriteCell";
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FavoriteCell;
        let groupName = groupDetails[indexPath.row];
        cell.favoriteNameLabel.text = groupName.name;
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            let alert:UIAlertView = UIAlertView(title: "", message: "确定要删除吗", delegate: self, cancelButtonTitle: "取消" )
            alert.addButton(withTitle: "删除")
            alert.delegate = self
            alert.show()
            alert.tag = 100
            needDeleteIndex = indexPath.row;
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // MARK: UIAlertViewDelegate
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if alertView.tag == 100 {
            if 0 == buttonIndex {
                refreshView()
            }
            if 1 == buttonIndex {
                let tmp = groupDetails[needDeleteIndex!]
                LogicBus.sharedInstance.groupDetail.remove(tmp, index: needDeleteIndex!, categoryName: (currentGropCategory?.categoryName)!)
                groupDetails.remove(at: needDeleteIndex!)
                refreshView()
            }
        }
    }



    // MARK: - Private methods
    
    func loadDatas() {
        if let tmpDetails = CacheBus.ins().favorite.loadCachedFavorites(forCategory: currentGropCategory?.categoryName) {
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
    
    func didTap(_ noResultsView: HYNoResultsView!) {
        //addFavoriteCategory(0)
        self.performSegue(withIdentifier: "AddFavoriteItem", sender: 0)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "enterFavoriteDetail" {
            let fvoriteDetailVC = segue.destination as! FavoriteDetailVC;
            if let selectedCell = sender as? FavoriteCell {
                let indexPath = tableView.indexPath(for: selectedCell)!
                let selectedFavorite = groupDetails[indexPath.row]
                fvoriteDetailVC.currentFavorite = selectedFavorite
            }
        }
    }
    

}
