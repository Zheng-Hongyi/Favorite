//
//  AddFavoriteItemVC.swift
//  Favorites
//
//  Created by 洪毅 郑 on 16/3/13.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

import UIKit

class AddFavoriteItemVC: BaseVC, UITextFieldDelegate {

    @IBOutlet weak var itemLInkTextFiled: UITextField!
    @IBOutlet weak var itemNameTextFiled: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var currentItem : Favorite?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        itemNameTextFiled.delegate = self;
        itemLInkTextFiled.delegate = self;
        checkValidMealName();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        itemLInkTextFiled.resignFirstResponder();
        itemNameTextFiled.resignFirstResponder();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelAction(_ sender: AnyObject) {
        dismiss(animated: true) { () -> Void in
            
        }
    }
    
    func checkValidMealName() {
        let text = itemLInkTextFiled.text ?? ""
        let text2 = itemNameTextFiled.text ?? ""
        if text.hasPrefix("http://") || text.hasPrefix("https://") {
            saveButton.isEnabled = !text.isEmpty && !text2.isEmpty
        } else {
            saveButton.isEnabled = false
            if !text.isEmpty {
                SVProgressHUD.showError(withStatus: "链接格式不对")
            }
        }
    
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if saveButton == sender as! UIBarButtonItem {
            let nameText = itemNameTextFiled.text ?? ""
            let linkText = itemLInkTextFiled.text ?? ""
            currentItem = Favorite(name: nameText, source: linkText)
        }
    }
    
    // MARk: UITextFiledDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidMealName()
        navigationItem.title = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        itemLInkTextFiled.resignFirstResponder();
        itemNameTextFiled.resignFirstResponder();
        return true
    }


}
