//
//  CustomButton.swift
//  SwiftTest
//
//  Created by Phyo Kyaw Swar on 25/1/17.
//  Copyright © 2017 PhyoKyawSwar. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

   
    
    required init?(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).CGColor
        self.layer.shadowOffset = CGSizeMake(2.0, 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 0.0
        self.backgroundColor = UIColor(red: 171, green: 178, blue: 186, alpha: 1.0)
            
        }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
