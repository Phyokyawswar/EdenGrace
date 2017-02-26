//
//  ReviewViewController.swift
//  MaidAgency
//
//  Created by Phyo Kyaw Swar on 1/2/17.
//  Copyright © 2017 PhyoKyawSwar. All rights reserved.
//

import UIKit



class ReviewViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var tblReview: UITableView!
    
    var Review_array :NSMutableArray = NSMutableArray()
    var imgAddViewBG : UIImageView!
    
    @IBOutlet weak var imgLoadingBG: UIImageView!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var lblLoading: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var AddView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnRate1: UIButton!
    @IBOutlet weak var btnRate2: UIButton!
    @IBOutlet weak var btnRate3: UIButton!
    @IBOutlet weak var btnRate4: UIButton!
    @IBOutlet weak var btnRate5: UIButton!
    @IBOutlet weak var lblDec: UILabel!
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var rating_count : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblReview.estimatedRowHeight = 43.0;
        tblReview.rowHeight = UITableViewAutomaticDimension
        
        self.showLoading()
        AddView.hidden = true
        
        self.performSelector(#selector(ReviewViewController.callAPI), withObject: nil, afterDelay: 1.0)

        if revealViewController() != nil
        {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
           
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
        }
        
        let nav = customNav()
        self.navigationItem.titleView = nav.navTitle()
        
        
        

        imgLoadingBG.backgroundColor = UIColor(white: 1, alpha: 0.5)
       
    }
    
    func callAPI()
    {
        
        let api:DataModel = DataModel()
        
       let Array = api.getReviewData("https://www.edengracemaids.com/customer-review")
        
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true)
        let documentsDirectory = paths.first! as NSString
        let filePath = documentsDirectory.stringByAppendingPathComponent("Review.json")
        
        if Array.count > 0
        {
           
            
               print("data not nil")
                
                self.writeFile(filePath, inputStream: Array)
                
                
           
        }
        
       Review_array = self.readFile(filePath)
        
        tblReview.reloadData()
        self.hideLoading()
        
    }
    
    
    func showLoading ()
    {
        activity.hidden = false
        imgLoadingBG.hidden = false
        lblLoading.hidden = false
        
        activity.startAnimating()
        
        
    }
    func hideLoading ()
    {
        activity.hidden = true
        imgLoadingBG.hidden = true
        lblLoading.hidden = true
        
        activity.stopAnimating()
       
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Review_array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let table_cell = tableView.dequeueReusableCellWithIdentifier("ReviewCell") as! ReviewTableViewCell
        
        let Review_Dict : NSDictionary = Review_array[indexPath.row] as! NSDictionary
        
        table_cell.lblTitle.text = Review_Dict["post_reviewer"] as? String
        
        table_cell.lblDate.text = Review_Dict["post_date"] as? String
        
        table_cell.lblDetail.numberOfLines = 0;
        table_cell.lblDetail.text = Review_Dict["post_content"] as? String
        table_cell.lblDetail.sizeToFit()
        
        table_cell.imgSp.backgroundColor = UIColor.lightGrayColor()
        
        
       // let rating_value = Review_Dict["post_rating"] as! String
        
        let rating : Int  = Review_Dict["post_rating"] as! Int
       
        print(rating)
        if rating > 0
        {
            if rating == 1
            {
                table_cell.btnRating1 .setBackgroundImage(UIImage(named: "rating.png"), forState: .Normal)
            }
            else if rating == 2
            {
                table_cell.btnRating1 .setBackgroundImage(UIImage(named: "rating.png"), forState: .Normal)
                table_cell.btnRating2 .setBackgroundImage(UIImage(named: "rating.png"), forState: .Normal)
                
            }
            else if rating == 3
            {
                table_cell.btnRating1 .setBackgroundImage(UIImage(named: "rating.png"), forState: .Normal)
                table_cell.btnRating2 .setBackgroundImage(UIImage(named: "rating.png"), forState: .Normal)
                table_cell.btnRating3 .setBackgroundImage(UIImage(named: "rating.png"), forState: .Normal)
                
                
            }
            else if rating == 4
            {
                table_cell.btnRating1 .setBackgroundImage(UIImage(named: "rating.png"), forState: .Normal)
                table_cell.btnRating2 .setBackgroundImage(UIImage(named: "rating.png"), forState: .Normal)
                table_cell.btnRating3 .setBackgroundImage(UIImage(named: "rating.png"), forState: .Normal)
                table_cell.btnRating4 .setBackgroundImage(UIImage(named: "rating.png"), forState: .Normal)
                
                
                
            }
            else
            {
                
                table_cell.btnRating1 .setBackgroundImage(UIImage(named: "rating.png"), forState: .Normal)
                table_cell.btnRating2 .setBackgroundImage(UIImage(named: "rating.png"), forState: .Normal)
                table_cell.btnRating3 .setBackgroundImage(UIImage(named: "rating.png"), forState: .Normal)
                table_cell.btnRating4 .setBackgroundImage(UIImage(named: "rating.png"), forState: .Normal)
                table_cell.btnRating5 .setBackgroundImage(UIImage(named: "rating.png"), forState: .Normal)
                
            }
            
            
        }
        
        table_cell.selectionStyle = UITableViewCellSelectionStyle.None
        
       
        return table_cell
    }
    
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
     func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
  
    @IBAction func onClickAdd(sender: AnyObject) {
        
       self.prepareView()   
    }
    
    func prepareView()
    {
        AddView.hidden = false
        AddView.layer.cornerRadius = 5
         imgLoadingBG.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        
        imgLoadingBG.hidden = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(ReviewViewController.handleTap(_:)))
        imgLoadingBG.userInteractionEnabled = true
        imgLoadingBG.addGestureRecognizer(tap)
        
        let BDtextField : CALayer = CALayer()
        BDtextField.frame = CGRectMake(0.0, txtName.frame.size.height - 1, txtName.frame.size.width, 1.0)
        BDtextField.backgroundColor = UIColor(red: 129.0/255.0, green: 194.0/255.0, blue: 77.0/255.0, alpha: 1.0 ).CGColor
       txtName.layer.addSublayer(BDtextField)
        
        txtName.placeholder = "Enter your Name or Email"
        
        txtDesc.text = "Comment"
        
        let BDtextView : CALayer = CALayer()
        BDtextView.frame = CGRectMake(0.0, txtDesc.frame.size.height - 1, txtDesc.frame.size.width, 1.0)
        BDtextView.backgroundColor = UIColor(red: 129.0/255.0, green: 194.0/255.0, blue: 77.0/255.0, alpha: 1.0 ).CGColor
        txtDesc.layer.addSublayer(BDtextView)
        
        btnRate1.setBackgroundImage(UIImage(named: "rating_gray"), forState: .Normal)
        btnRate2.setBackgroundImage(UIImage(named: "rating_gray"), forState: .Normal)
        btnRate3.setBackgroundImage(UIImage(named: "rating_gray"), forState: .Normal)
        btnRate4.setBackgroundImage(UIImage(named: "rating_gray"), forState: .Normal)
        btnRate5.setBackgroundImage(UIImage(named: "rating_gray"), forState: .Normal)
        
    }
    
    func handleTap(sender : UITapGestureRecognizer)
    {
        self.hideAddView()
    }
    
   @IBAction func textFieldDidEndEditing(textField: UITextField) {
        txtName.resignFirstResponder()
    }
    
   @IBAction func textFieldShouldEndEditing(textField: UITextField) {
        txtName.resignFirstResponder()
    
        
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        
        scrollView.contentSize = CGSizeMake(280, 450)
        txtDesc.text = ""
        txtDesc.textColor = UIColor.lightGrayColor()
        return true
    
    }
    
    func textViewDidChange(textView: UITextView) {
        if textView.text.isEmpty
        {
           txtDesc.text = "Comment"
            txtDesc.resignFirstResponder()
            
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"
        {
            scrollView.contentSize = CGSizeMake(280, 300)
            
            textView.resignFirstResponder()
            return false
            
        }
        return true
        
    }
    
    @IBAction func onClickRate (sender : AnyObject)
    {
        switch sender.tag
        {
        case 11 : btnRate1.setBackgroundImage(UIImage(named: "rating"), forState: .Normal)
                  btnRate2.setBackgroundImage(UIImage(named: "rating_gray"), forState: .Normal)
                  btnRate3.setBackgroundImage(UIImage(named: "rating_gray"), forState: .Normal)
                  btnRate4.setBackgroundImage(UIImage(named: "rating_gray"), forState: .Normal)
                  btnRate5.setBackgroundImage(UIImage(named: "rating_gray"), forState: .Normal)
                  rating_count = 1
                  break
            
        case 22 : btnRate1.setBackgroundImage(UIImage(named: "rating"), forState: .Normal)
                  btnRate2.setBackgroundImage(UIImage(named: "rating"), forState: .Normal)
                  btnRate3.setBackgroundImage(UIImage(named: "rating_gray"), forState: .Normal)
                  btnRate4.setBackgroundImage(UIImage(named: "rating_gray"), forState: .Normal)
                  btnRate5.setBackgroundImage(UIImage(named: "rating_gray"), forState: .Normal)
                  rating_count = 2
                  break
            
        case 33 : btnRate1.setBackgroundImage(UIImage(named: "rating"), forState: .Normal)
                  btnRate2.setBackgroundImage(UIImage(named: "rating"), forState: .Normal)
                  btnRate3.setBackgroundImage(UIImage(named: "rating"), forState: .Normal)
                  btnRate4.setBackgroundImage(UIImage(named: "rating_gray"), forState: .Normal)
                  btnRate5.setBackgroundImage(UIImage(named: "rating_gray"), forState: .Normal)
                  rating_count = 3
                  break
            
        case 44 : btnRate1.setBackgroundImage(UIImage(named: "rating"), forState: .Normal)
                  btnRate2.setBackgroundImage(UIImage(named: "rating"), forState: .Normal)
                  btnRate3.setBackgroundImage(UIImage(named: "rating"), forState: .Normal)
                  btnRate4.setBackgroundImage(UIImage(named: "rating"), forState: .Normal)
                  btnRate5.setBackgroundImage(UIImage(named: "rating_gray"), forState: .Normal)
                  rating_count = 4
                  break
            
        case 55 : btnRate1.setBackgroundImage(UIImage(named: "rating"), forState: .Normal)
                  btnRate2.setBackgroundImage(UIImage(named: "rating"), forState: .Normal)
                  btnRate3.setBackgroundImage(UIImage(named: "rating"), forState: .Normal)
                  btnRate4.setBackgroundImage(UIImage(named: "rating"), forState: .Normal)
                  btnRate5.setBackgroundImage(UIImage(named: "rating"), forState: .Normal)
                  rating_count = 5
                  break
        default : break

            
        
        }
    }
    
    @IBAction func onClickDone (sender : AnyObject)
    {
        
        let currentDate = NSDate()
        let dateformatter : NSDateFormatter = NSDateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateformatter.stringFromDate(currentDate)
        
        
        let dict : NSDictionary = ["post_rating":rating_count,"post_name":txtName.text!,"email":txtName.text!,"post_title":txtName.text!,"website":"","post_content":txtDesc.text,"post_date":dateString]
        
        let api:DataModel = DataModel()
        
        let dictionary = api.postCustomerReview(dict)
        
        print(dictionary)
        
        var alert : UIAlertController = UIAlertController()
        if dictionary["Message"] != nil
        {
            alert = UIAlertController(title: "Information", message: dictionary["Message"] as! String, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler:
                {
                    action in
                    
                    self.hideAddView()
                    
            }));
            
            
        }
        else
        {
            
            alert = UIAlertController(title: "Information", message:"The Internet connection appears to be offline.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler:
                {
                    action in
                    
                  
                    
            }));

        }
       
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    func hideAddView ()
    {
        AddView.hidden = true
        imgLoadingBG.hidden = true
        
    }
    
    
    
    func writeFile (filename:String , inputStream : NSMutableArray) -> Void
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
            
            readArray = try (NSJSONSerialization.JSONObjectWithData(data, options:.AllowFragments)as! NSArray).mutableCopy() as! NSMutableArray
            
           
        }catch let jsonError as NSError {
            print(jsonError.localizedDescription)
        }
        
        return readArray
        
    }

  }
