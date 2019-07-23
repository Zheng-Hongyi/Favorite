//
//  FavoriteHomeVC.swift
//  Favorites
//
//  Created by 洪毅 郑 on 16/2/21.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

import UIKit

class FavoriteHomeVC: BaseTVC, HYNoResultsViewDelegate, UIAlertViewDelegate{
    
    var groupNames = [FavoriteCategory]()
    var noResultView:HYNoResultsView?
    var needDeleteIndex: Int?
    
    
    let userKey = "addmin"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "X-收藏";
        configView()
        loadGroupNames();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Private methods
    func loadGroupNames () {
        if let tmpGroupNames =  CacheBus.ins().category.loadCachedCategories(forKey: userKey) {
            groupNames = tmpGroupNames as! [FavoriteCategory];
        } else {
            print("error")
        }
        refreshView()
    }
    
    func refreshView() {
        if 0 == groupNames.count {
            tableView.addSubview(noResultView!)
        } else {
            noResultView?.removeFromSuperview()
        }
        tableView.reloadData();
    }
    
    func configView () {
        noResultView = HYNoResultsView.init(title: "没有添加任何内容", message: "你还没有添加任何类别，例如学习、健身等等", accessoryView: nil, buttonTitle: "添加")
        noResultView?.delegate = self
        tableView.tableFooterView = UIView.init();
    }
    
    @IBAction func addFavoriteCategory(_ sender: AnyObject) {
        print("hello world")
        self.performSegue(withIdentifier: "AddGroup", sender: 0)
    }
   
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupNames.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "GroupCell";
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GroupCell;
        let groupName = groupNames[indexPath.row];
        cell.groupNameLabel.text = groupName.categoryName;
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
    
    @IBAction func unwindToHomeList(_ sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddFavoriteCategoryVC, let needAddedCategory = sourceViewController.currentCategory {
            groupNames.append(needAddedCategory)
            refreshView()
            CacheBus.ins().category.cacheCategories(needAddedCategory, forKey: userKey)
            //CacheBus.sharedInstance.favoriteCategory.cacheFavoriteCategories(groupNames, cacheKey: userKey)
            
        }
    }
    
    // MARK: - HYNoResultViewDelegate
    
    func didTap(_ noResultsView: HYNoResultsView!) {
        addFavoriteCategory(0 as AnyObject)
    }
    
    // MARK: - UIAlertViewDelegate
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if alertView.tag == 100 {
            if 0 == buttonIndex {
                refreshView()
            }
            if 1 == buttonIndex {
                let tmp = groupNames[needDeleteIndex!]
                LogicBus.sharedInstance.homeLogic.remove(tmp, index: needDeleteIndex!,userKey: userKey)
                groupNames.remove(at: needDeleteIndex!)
                refreshView()
            }
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDetailGroup" {
            let groupDetailViewController = segue.destination as! FavoriteGroupDetailVC
            if let selectedCell = sender as? GroupCell {
                let indexPath = tableView.indexPath(for: selectedCell)!
                let selectedCategory = groupNames[indexPath.row]
                groupDetailViewController.currentGropCategory = selectedCategory
            }
        
        } else if segue.identifier == "AddGroup" {
            
        }
    }


}
