//
//  SkillTableViewCell.swift
//  MaidAgency
//
//  Created by Phyo Kyaw Swar on 6/2/17.
//  Copyright © 2017 PhyoKyawSwar. All rights reserved.
//

import UIKit

class SkillTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSkill: UILabel!
    @IBOutlet weak var imgSp: UIImageView!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
