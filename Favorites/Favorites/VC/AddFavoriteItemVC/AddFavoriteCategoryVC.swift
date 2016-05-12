//
//  AddFavoriteCategoryVC.swift
//  Favorites
//
//  Created by 洪毅 郑 on 16/3/6.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

import UIKit

class AddFavoriteCategoryVC: BaseVC, UITextFieldDelegate {

    @IBOutlet weak var groupNameTextFiled: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var currentCategory : FavoriteCategory?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        groupNameTextFiled.delegate = self
        checkValidMealName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private methods

    @IBAction func cancelAdd(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func checkValidMealName() {
        let text = groupNameTextFiled.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if saveButton === sender {
            let groupName = groupNameTextFiled.text ?? ""
            currentCategory = FavoriteCategory(tmpName: groupName)
        }
    }
    
    // MARk: UITextFiledDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled = false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidMealName()
        navigationItem.title = textField.text
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        groupNameTextFiled.resignFirstResponder()
        return true
    }

}