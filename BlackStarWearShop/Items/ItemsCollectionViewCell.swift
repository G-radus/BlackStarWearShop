//
//  ItemsCollectionViewCell.swift
//  BlackStarWearShop
//
//  Created by Rustam Gradov on 19.04.2020.
//  Copyright © 2020 Rustam Gradov. All rights reserved.
//

import UIKit

class ItemsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
   
    @IBOutlet weak var buyButtonRectangle: UIView!
    override func layoutSubviews() {
           self.buyButtonRectangle.layer.cornerRadius = 5
    }
}
