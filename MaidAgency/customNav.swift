//
//  customNav.swift
//  MaidAgency
//
//  Created by Phyo Kyaw Swar on 7/2/17.
//  Copyright © 2017 PhyoKyawSwar. All rights reserved.
//

import UIKit

class customNav: NSObject {
    func navTitle()->UIView
    {
       
        
        let navView = UIView()
        
        // Create the label
        let label = UILabel()
        label.text = "Eden Grace"
        label.font = UIFont(name: "Roboto-Medium", size: 15.0)
        label.textColor = UIColor(red: 25.0/255.0, green: 130.0/255.0, blue: 68.0/255.0, alpha: 1.0)
        label.sizeToFit()
        label.center = navView.center
        label.textAlignment = NSTextAlignment.Center
        
        // Create the image view
        let image = UIImageView()
        image.image = UIImage(named: "logo.png")
        // To maintain the image's aspect ratio:
        let imageAspect = image.image!.size.width/image.image!.size.height
        // Setting the image frame so that it's immediately before the text:
        image.frame = CGRect(x: label.frame.origin.x - 42, y: label.frame.origin.y - 12, width: 40, height: 40)
        image.contentMode = UIViewContentMode.ScaleAspectFit
        
        
        // Add both the label and image view to the navView
        navView.addSubview(label)
        navView.addSubview(image)
        
        // Set the navigation bar's navigation item's titleView to the navView
        //self.navigationItem.titleView = navView
        
        // Set the navView's frame to fit within the titleView
        //navView.sizeToFit()
        
        return navView
    }
}
