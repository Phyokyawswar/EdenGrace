//
//  WhyAdenViewController.swift
//  MaidAgency
//
//  Created by Phyo Kyaw Swar on 1/2/17.
//  Copyright © 2017 PhyoKyawSwar. All rights reserved.
//

import UIKit

class WhyAdenViewController: UIViewController,YTPlayerViewDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!

    @IBOutlet weak var lblWhy: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblAchievement: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var player: YTPlayerView!
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
            let htmlString = "<p><strong>Our Achievement</strong> - It does without saying that we at Eden Grace Maids view Quality Selection, Quality Training and Integration Program as top priority. For the quest towards Service, it is always an endless pursuit towards excellence. Now as we are on our placing employers&rsquo; needs on our top list. While the work is in phase, we are glad to share with our progress.&nbsp;</p><p><strong>Quality Selection </strong>&ndash; During the past years we have been travelling to our source country like Philippines. Understanding quality selection and personal screening of the applicants before selecting them as potential applicants is important. This Year we have also involve their family members as part of the screening as we want to be very sure that their family are ready and prepared before they leave for Singapore.</p><p><strong>Quality Training </strong>&ndash; To provide a more seamless experience, we have invested towards quality check. Upon arrival, they will undergo quality check base on their job offer, understanding of work adjustment, orientation and continue follow up if they are joining us on our Sunday program.</p><p><strong>Intergration Program</strong> &ndash; We believe that bonding between employer and helper will take time. It requires understanding, patience and mutual respect. As a result, besides our Sunday program, We have set up accountability group for helpers to help them to grow through character building. This is just a preview of what we&rsquo;re doing and we can assure you of our commitment to help you and your helper build a harmonious working relationships. We look forward to share with you latest updates as we go along.</p><p align=\"right\"><strong>Thank you for choosing Eden Grace Maids!!!</strong></p> <p align=\"right\"><em>Sunny Wong</em></p><p align=\"right\"><strong>Founder and Managing Director</strong></p>"
        
        webView.loadHTMLString(htmlString, baseURL: nil)
      self.performSelector(#selector(WhyAdenViewController.setScrollSize), withObject: nil, afterDelay: 1.0)
        
        
        let dict = ["autoplay":"1","origin" : "http://www.youtube.com","playsinline":"1"]
        self.player.loadWithVideoId("gPZt24avRQQ", playerVars: dict)
        self.player.delegate = self
       
        
       
    }
    /*
     (void)playerViewDidBecomeReady:(YTPlayerView *)playerView{
     [[NSNotificationCenter defaultCenter] postNotificationName:@"Playback started" object:self];
     [self.playerView playVideo];
     }
 */
    func playerViewDidBecomeReady(playerView: YTPlayerView!) {
        NSNotificationCenter.defaultCenter().postNotificationName("Playback started", object: self)
        
        playerView.playVideo()
    }
    func setScrollSize ()
    {
        scrollView.contentSize = CGSizeMake(300, 1200)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
