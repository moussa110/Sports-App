//
//  SportsViewCell.swift
//  Sports App
//
//  Created by MacOSSierra on 3/1/21.
//  Copyright © 2021 mousa. All rights reserved.
//

import UIKit

class SportsViewCell: UICollectionViewCell {
    @IBOutlet weak var strSportLbl: UILabel!
    @IBOutlet weak var imgSport: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 13
        self.imgSport.layer.cornerRadius = 13
        self.imgSport.clipsToBounds = true
        // Your border code here (set border to contentView)
        //            self.contentView.layer.borderColor = UIColor.blue.cgColor
        //            self.contentView.layer.borderWidth = 1
    }
    
}
