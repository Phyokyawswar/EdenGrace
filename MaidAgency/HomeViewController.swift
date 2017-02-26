//
//  HomeViewController.swift
//  MaidAgency
//
//  Created by Phyo Kyaw Swar on 1/2/17.
//  Copyright © 2017 PhyoKyawSwar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var extraButton : UIBarButtonItem!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var imgSearch: UIImageView!
    @IBOutlet weak var imgSearchGreen: UIImageView!
    @IBOutlet weak var lblSearch: UILabel!
    @IBOutlet weak var btnWhy: UIButton!
    @IBOutlet weak var imgWhy: UIImageView!
    @IBOutlet weak var imgWhyGreen: UIImageView!
    @IBOutlet weak var lblWhy: UILabel!
    @IBOutlet weak var btnSuccess: UIButton!
    @IBOutlet weak var imgSuccess: UIImageView!
    @IBOutlet weak var imgSuccessGreen: UIImageView!
    @IBOutlet weak var lblSuccess: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil
        {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
           
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        let dot_menu = UIBarButtonItem()
        dot_menu.action = #selector(HomeViewController.MoreFunc)
        dot_menu.target = self
        dot_menu.image = UIImage(named: "dot_menu")
        self.navigationItem.rightBarButtonItem = dot_menu
        
        
        imgSearchGreen.backgroundColor = UIColor(red: 129.0/255.0, green: 194.0/255.0, blue: 77.0/255.0, alpha: 1.0 )
         imgWhyGreen.backgroundColor = UIColor(red: 129.0/255.0, green: 194.0/255.0, blue: 77.0/255.0, alpha: 1.0 )
         imgSuccessGreen.backgroundColor = UIColor(red: 129.0/255.0, green: 194.0/255.0, blue: 77.0/255.0, alpha: 1.0 )
        
        //btnSuccess.backgroundColor = UIColor(red: 171, green: 178, blue: 186, alpha: 1.0)
        // Shadow and Radius
       

        btnWhy.backgroundColor = UIColor.whiteColor()
        btnSearch.backgroundColor = UIColor.whiteColor()
        
        let nav = customNav()
       self.navigationItem.titleView = nav.navTitle()
        
       
    }
    
    
  
    
    func MoreFunc()
    {
        let alert: UIAlertController = UIAlertController(title: "", message: "", preferredStyle: .ActionSheet)
        alert.addAction(UIAlertAction(title: "Call Us", style: .Default, handler:
            {
                action in
                
         
                let phoneurl = NSURL(string: "+6562625562")
                if UIApplication.sharedApplication().canOpenURL(phoneurl!)
                {
                    UIApplication.sharedApplication().openURL(phoneurl!)
                }
                else
                {
                    
                    let alert = UIAlertView (title: "Information", message: "Call facility is not available!!!", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                    
                }
        }))
        
        
        alert.addAction(UIAlertAction(title: "Website", style: .Default, handler:
            {
                action in
                
                let weburl = NSURL(string: "https://www.edengracemaids.com")
                if UIApplication.sharedApplication().canOpenURL(weburl!)
                {
                    UIApplication.sharedApplication().openURL(weburl!)
                }
                else
                {
                    
                    let alert = UIAlertView (title: "Information", message: "Can't open your website!!", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                    
                }
                
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickWhyEdenGrace(sender: AnyObject) {
        
        let board : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
       let  vc = board.instantiateViewControllerWithIdentifier("WhyAdenNav")
        let segue : SWRevealViewControllerSeguePushController = SWRevealViewControllerSeguePushController.init(identifier: "id", source: self, destination: vc)
        segue.perform()

    }
    
    @IBAction func onClickSuccessfulStories(sender: AnyObject) {
        
        let board : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let  vc = board.instantiateViewControllerWithIdentifier("SuccessStroiesNav")
        let segue : SWRevealViewControllerSeguePushController = SWRevealViewControllerSeguePushController.init(identifier: "id", source: self, destination: vc)
        segue.perform()
        
    }
    
    @IBAction func onClickSearch (sender : AnyObject)
    {
        let board : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let  vc = board.instantiateViewControllerWithIdentifier("CountryView") as! CountryViewController
        let delegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        delegate.fromMenu = false
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

   

}
