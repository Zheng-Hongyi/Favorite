//
//  FavoriteCell.swift
//  Favorites
//
//  Created by Hongyi Zheng on 16/3/19.
//  Copyright © 2016年 洪毅 郑. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var favoriteNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
