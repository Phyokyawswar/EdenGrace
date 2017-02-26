//
//  MenuController.swift
//  SidebarMenu
//
//  Created by Simon Ng on 2/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class MenuController: UITableViewController {

    let Menu_Array = ["Home","Search Helper","Successful Stories","Why Eden Grace","Customer Review","Contact Us","Enquiry"]
    let Image_Array = ["home.png","search.png","successful.png","whyadengrace.png","review.png","callIcon.png","emailIcon.png"]
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Menu_Array.count+1;
        
    }


    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0
        {
            return 153.0
        }
        else
        {
            return 52.0
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0
        {
            
            let header_cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell", forIndexPath: indexPath) as! HeaderTableViewCell
            header_cell.contentView.backgroundColor = UIColor(red: 129.0/255.0, green: 194.0/255.0, blue: 77.0/255.0, alpha: 1.0 )
            
            return header_cell
        }
        else
        {
         
             let menu_cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! MenuTableViewCell
            
            menu_cell.lblMenu.text = Menu_Array[indexPath.row - 1]
            menu_cell.lblMenu.highlightedTextColor = UIColor(red: 129.0/255.0, green: 194.0/255.0, blue: 77.0/255.0, alpha: 1.0 )
            
            menu_cell.imgLogo.image = UIImage(named: Image_Array[indexPath.row - 1])
            
            
            return menu_cell
        }
           
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
       
        var identifier  : String = ""
        
        if indexPath.row == 1
        {
           identifier = "HomeNav"
            
        }
        else if indexPath.row == 2
        {
            let delegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            delegate.fromMenu = true
             identifier = "CountryNav"
            
            
        }

        else if indexPath.row == 3
        {
            identifier = "SuccessStroiesNav"
           
        }
        else if indexPath.row == 4
        {
            identifier = "WhyAdenNav"
            
        }
       else if indexPath.row == 5
        {
             identifier = "ReviewNav"
          
            
        }
        else if indexPath.row == 6
        {
            
            identifier = "ContactUs"
        }
        else
        {
            identifier = "EnquireNav"
        }
        
        print(indexPath.row)
     self.performSegueWithIdentifier(identifier, sender: nil)
       
    }
    

    override func performSegueWithIdentifier(identifier: String, sender: AnyObject?) {
        let board : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
       
        let vc = board.instantiateViewControllerWithIdentifier(identifier)
        let segue : SWRevealViewControllerSeguePushController = SWRevealViewControllerSeguePushController.init(identifier: "id", source: self, destination: vc)
        segue.perform()
    }
    
}
