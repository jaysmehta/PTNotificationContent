//
//  CollectionViewCell.swift
//  PTNotificationContent
//
//  Created by Jay Mehta on 18/08/20.
//  Copyright © 2020 Jay Mehta. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let caLayer = self.layer
        caLayer.cornerRadius = 5

    }
    
}
