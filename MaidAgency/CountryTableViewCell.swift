//
//  CountryTableViewCell.swift
//  MaidAgency
//
//  Created by Phyo Kyaw Swar on 2/2/17.
//  Copyright © 2017 PhyoKyawSwar. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var imgMaid: UIImageView!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var imgNext: UIImageView!
    @IBOutlet weak var imgCellBG: UIImageView!
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
