//
//  SuccessViewController.swift
//  MaidAgency
//
//  Created by Phyo Kyaw Swar on 2/2/17.
//  Copyright © 2017 PhyoKyawSwar. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {

    @IBOutlet weak var menuButton:UIBarButtonItem!
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var Segment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil
        {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
        }
        
        let nav = customNav()
        self.navigationItem.titleView = nav.navTitle()
        
        

        
        
        let url = NSURL (string: "https://www.edengracemaids.com/successful-stories-of-employers/")
        let requestObj = NSURLRequest(URL: url!);
        webView.loadRequest(requestObj)
      
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func SegmentClick(sender: AnyObject)
    {
        if Segment.selectedSegmentIndex == 0
        {
            let url = NSURL (string: "https://www.edengracemaids.com/successful-stories-of-employers/")
            let requestObj = NSURLRequest(URL: url!);
            webView.loadRequest(requestObj)
            

        }
        else
        {
           
            
            let url = NSURL (string: "https://www.edengracemaids.com/successful-stories-of-maids/")
            let requestObj = NSURLRequest(URL: url!);
            webView.loadRequest(requestObj)
            

        }
    }
   
}
