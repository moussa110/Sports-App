//
//  LeagueCell.swift
//  Sports App
//
//  Created by MacOSSierra on 2/21/21.
//  Copyright © 2021 mousa. All rights reserved.
//

import UIKit


protocol DemoClickDelegate {
    func onClick(index : Int);
}
class LeagueTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leagueLogoIV: UIImageView!
    @IBOutlet weak var leagueNameLBL: UILabel!
    
    var demoDelegate:DemoClickDelegate?;
    var index:IndexPath?;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        //self.leagueLogoIV = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        self.leagueLogoIV.layer.masksToBounds = true
        self.leagueLogoIV.layer.cornerRadius = self.leagueLogoIV.bounds.width / 2
        
        self.contentView.layer.cornerRadius = 13
        // Your border code here (set border to contentView)
        self.leagueLogoIV.layer.borderColor = UIColor.green.cgColor
        self.contentView.layer.borderWidth = 1
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func demoAction(_ sender: Any) {
        demoDelegate?.onClick(index: index!.row)
    }
}
