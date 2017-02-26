//
//  CountryViewController.swift
//  MaidAgency
//
//  Created by Phyo Kyaw Swar on 2/2/17.
//  Copyright © 2017 PhyoKyawSwar. All rights reserved.
//

import UIKit
import MediaPlayer

class CountryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,YTPlayerViewDelegate {

    var country_flag : NSMutableArray = NSMutableArray()
    var country_array : NSMutableArray = NSMutableArray()
    var Json_file_path : String = String()
    var selected_country_array : NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var menuButton : UIBarButtonItem!
    @IBOutlet weak var imgLoadingBG: UIImageView!
    @IBOutlet weak var lblLoading: UIActivityIndicatorView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var tblCountry: UITableView!
    
    var moviePlayer : MPMoviePlayerController!
    @IBOutlet weak var playerView: YTPlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideLoading()
       // self.performSelector(#selector(CountryViewController.getCountryList), withObject: nil, afterDelay: 1.0)


        let nav = customNav()
        self.navigationItem.titleView = nav.navTitle()
        
        let delegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        if  delegate.fromMenu == false
        {
            let btnBack = UIBarButtonItem()
            btnBack.action = #selector(CountryViewController.goBack)
            btnBack.target = self
            btnBack.image = UIImage(named: "white_arrow")
            self.navigationItem.leftBarButtonItem = btnBack
            
        }
        else
        {
            if revealViewController() != nil
            {
                menuButton.target = revealViewController()
                menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
                
                view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                
            }
        }
        
        country_array = ["Philippines","Indonesia","Others"]
        country_flag = ["phillipine","indo","indo"]
        
      
      //https://youtu.be/lQKi9e5pgzY
        
        let dict = ["autoplay":"1","origin" : "http://www.youtube.com","playsinline":"1"]
        self.playerView.loadWithVideoId("lQKi9e5pgzY", playerVars: dict)
        self.playerView.delegate = self
        
        

        // Do any additional setup after loading the view.
    }
    
    func playerViewDidBecomeReady(playerView: YTPlayerView!) {
        NSNotificationCenter.defaultCenter().postNotificationName("Playback started", object: self)
        
        playerView.playVideo()
    }


        func goBack()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
   /* func getCountryList ()
    {
        let api = DataModel()
        country_dict = api.getCountryData("http://innomaid.com.sg/api/v1/nationality?api_token=wcQbUTMMx7xPsqD0wTkjTA1hBMCOtFu93pFqJPmsB9n2xVSv")
        
        
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true)
        let documentsDirectory = paths.first! as NSString
        let filePath = documentsDirectory.stringByAppendingPathComponent("Country.json")
        
        
        
        if (country_dict["data"] != nil)
        {
            print("data not nil")
            
          self.writeFile(filePath, inputStream: country_dict)
            
           
        }
        
        country_array = self.readFile(filePath)
        
        
        self.hideLoading()
        tblCountry.reloadData()
        
        
    }
 */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return country_array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let table_cell = tableView.dequeueReusableCellWithIdentifier("CountryCell") as! CountryTableViewCell
      
        table_cell.imgMaid.image = UIImage(named: country_flag[indexPath.row] as! String)
        
        table_cell.lblCountry.text = country_array[indexPath.row] as! String
        
        table_cell.imgSp.backgroundColor = UIColor.lightGrayColor()
        
        table_cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return table_cell

        
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       let Country_Dict = country_array[indexPath.row]
        let board : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        if indexPath.row == 0
        {
            let  vc = board.instantiateViewControllerWithIdentifier("MaidsCategory") as! MaidsCategoryViewController
            vc.country_ID =  11
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        else if indexPath.row == 1
        {
          let  vc = board.instantiateViewControllerWithIdentifier("MaidsSearch") as! MaidsSearchViewController
            vc.countryID =  12
            self.navigationController?.pushViewController(vc, animated: true)
            

        }
        else
        {
            let  vc = board.instantiateViewControllerWithIdentifier("MaidsSearch") as! MaidsSearchViewController
            vc.countryID =  20
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        self.playerView.stopVideo()
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    /////////// Writing File////////////
    
    func writeFile (filename:String , inputStream : NSDictionary) -> Void
    {
       
        let outputStream = NSOutputStream(toFileAtPath: filename, append: false)
        outputStream?.open()
        NSJSONSerialization.writeJSONObject(
            inputStream,
            toStream: outputStream!,
            options: NSJSONWritingOptions.PrettyPrinted,
            error: nil)
        outputStream?.close()
    }
    
    
    func readFile (filepath : String) -> NSMutableArray
    {
        var readArray : NSMutableArray = NSMutableArray()
        
        do
        {
            
            let data : NSData = try NSData(contentsOfFile: filepath , options: NSDataReadingOptions.DataReadingMapped)
            
            let data_dict = try NSJSONSerialization.JSONObjectWithData(data, options:.AllowFragments) as! NSDictionary
            
            if (data_dict["data"] != nil)
            {
                readArray = (data_dict["data"] as! NSArray).mutableCopy() as! NSMutableArray                
            }
        }catch let jsonError as NSError {
            print(jsonError.localizedDescription)
        }
        
        return readArray
        
    }
    
    
   /* func showLoading ()
    {
        activityView.hidden = false
        imgLoadingBG.hidden = false
        lblLoading.hidden = false
        imgLoadingBG.backgroundColor = UIColor(white: 1, alpha: 0.3)
        
        activityView.startAnimating()
        
        
    }
 */
    func hideLoading ()
    {
        activityView.hidden = true
        imgLoadingBG.hidden = true
        lblLoading.hidden = true
        
        activityView.stopAnimating()
        
        
    }
 
    

}
