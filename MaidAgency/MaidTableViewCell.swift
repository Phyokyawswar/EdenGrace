//
//  MaidTableViewCell.swift
//  MaidAgency
//
//  Created by Phyo Kyaw Swar on 3/2/17.
//  Copyright © 2017 PhyoKyawSwar. All rights reserved.
//

import UIKit

class MaidTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblNation: UILabel!
    @IBOutlet weak var lblBirth: UILabel!
    @IBOutlet weak var imgSp: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
