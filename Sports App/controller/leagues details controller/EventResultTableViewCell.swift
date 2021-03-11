//
//  EventResultTableViewCell.swift
//  Sports App
//
//  Created by MacOSSierra on 3/4/21.
//  Copyright © 2021 mousa. All rights reserved.
//

import UIKit

class EventResultTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var awayTeamIv: UIImageView!
    @IBOutlet weak var awayScoreLbl: UILabel!
    @IBOutlet weak var awayTeamLbl: UILabel!
    @IBOutlet weak var homeScoreLbl: UILabel!
    @IBOutlet weak var homeTeamLbl: UILabel!
    @IBOutlet weak var homeTeamIv: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.contentView.layer.cornerRadius = 13
        self.homeTeamIv.layer.cornerRadius = 13
        self.homeTeamIv.clipsToBounds = true
        self.awayTeamIv.layer.cornerRadius = 13
        self.awayTeamIv.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5))
    }

}
