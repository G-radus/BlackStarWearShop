//
//  SubCategoryTableViewCell.swift
//  BlackStarWearShop
//
//  Created by Rustam Gradov on 30.03.2020.
//  Copyright © 2020 Rustam Gradov. All rights reserved.
//

import UIKit

class SubCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var subCategoryImageView: UIImageView!
    @IBOutlet weak var subCategoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
