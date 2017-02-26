//
//  ViewController.swift
//  MaidAgency
//
//  Created by Phyo Kyaw Swar on 1/2/17.
//  Copyright © 2017 PhyoKyawSwar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgBG: UIImageView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblHome: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
        imgBG.backgroundColor = UIColor(red: 129.0/255.0, green: 194.0/255.0, blue: 77.0/255.0, alpha: 1.0 )
        
        imgLogo.image = UIImage(named: "imgHome.png")
        
        lblHome.text = "AN AGENCY WITH A DIFFERENCE"
        lblHome.font = UIFont(name: "Roboto-MediumItalic", size: 17.0)
        
        btnStart.backgroundColor = UIColor(red: 25.0/255.0, green: 130.0/255.0, blue: 68.0/255.0, alpha: 1.0)
        btnStart.layer.cornerRadius = 5.0
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onClickStart(sender: AnyObject) {
        
        let board : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let RevelView : UIViewController = board.instantiateViewControllerWithIdentifier("SWReveal")
        self.presentViewController(RevelView, animated: true, completion: nil)
    }
}

