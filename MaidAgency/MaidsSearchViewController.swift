//
//  MaidsSearchViewController.swift
//  MaidAgency
//
//  Created by Phyo Kyaw Swar on 3/2/17.
//  Copyright © 2017 PhyoKyawSwar. All rights reserved.
//

import UIKit

protocol CustomSearchControllerDelegate {
    func didStartSearching()
    
    func didTapOnSearchButton()
    
    func didTapOnCancelButton()
    
    func didChangeSearchText(searchText: String)
}



class MaidsSearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate,UIDocumentInteractionControllerDelegate {

    var filter = UIBarButtonItem()
    var rangeSlider = GZRangeSlider()
    var countryID : Int = Int()
    var skill : String = String()
    var index : Int = 1
    
    var docController : UIDocumentInteractionController!
    var insearchBar : Bool = false
    var searchResults : NSMutableArray = NSMutableArray()
    var Result : NSMutableArray = NSMutableArray()
    
    var filterType : String = "code"
    var fromAge : Int = 20
    var toAge : Int = 80
    var url_filter : String = String()
    
    var refreshControl = UIRefreshControl()
    
    
    
    var Maid_Array : NSMutableArray = NSMutableArray()
    var Other_Array : NSMutableArray = NSMutableArray()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var tblMaids: UITableView!
    @IBOutlet weak var imgLoadingBG: UIImageView!
    @IBOutlet weak var lblLoading: UILabel!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var lblSearch: UILabel!
    @IBOutlet weak var btnCode: UIButton!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var imgCode: UIImageView!
    @IBOutlet weak var btnType: UIButton!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var btnAge: UIButton!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var lblAgeIndicator: UILabel!
    
    var Radio_Value : Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        definesPresentationContext = true
        SearchView.hidden = true
       
        filter = UIBarButtonItem()
        filter.action = #selector(MaidsSearchViewController.Filter)
        filter.target = self
        filter.image = UIImage(named: "filter")
        self.navigationItem.rightBarButtonItem = filter
        
        self.showLoading()
        
        if countryID == 20 {
            self.performSelector(#selector(MaidsSearchViewController.getOtherMaids), withObject: nil, afterDelay: 1.0)
            
            
        }
        else
        {
            self.performSelector(#selector(MaidsSearchViewController.getMaid), withObject: nil, afterDelay: 1.0)
            
            
        }
        
       let nav = customNav()
        self.navigationItem.titleView = nav.navTitle()
        
        
        
        let btnBack = UIBarButtonItem()
        btnBack.action = #selector(MaidsSearchViewController.goBack)
        btnBack.target = self
        btnBack.image = UIImage(named: "white_arrow")
        self.navigationItem.leftBarButtonItem = btnBack
        
        self.filter_url()
        
       
        
        refreshControl.triggerVerticalOffset = 100
        refreshControl.addTarget(self, action: #selector(MaidsSearchViewController.refresh), forControlEvents: .ValueChanged)
        self.tblMaids.bottomRefreshControl = refreshControl
        
        let kWidth: CGFloat = 300
        rangeSlider = GZRangeSlider(frame: CGRectMake(6,181,288,30))
        
    }
    
    func refresh()
    {
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            
            self.index+=1
            //self.performSelector(Selector("getMaid"), withObject: nil, afterDelay: 1.0)
            
            if self.countryID == 20
            {
                self.getOtherMaids()
            }
            else
            {
                self.getMaid()
                
                
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                print("This is run on the main queue, after the previous code in outer block")
                
            })
        })
        

    }
  
    
    func filter_url ()
    {
        if countryID == 20
        {
            url_filter = "http://innomaid.com.sg/api/v1/maids?api_token=m28lA7A5wrDrRo51o8MzEcIe7DDba406KVjcy8AcShgAmyU0"
          
        }
        else
        {
            url_filter = "http://innomaid.com.sg/api/v1/maids?api_token=wcQbUTMMx7xPsqD0wTkjTA1hBMCOtFu93pFqJPmsB9n2xVSv&nationality="+String(countryID)
            
        }
        
    }
    
    func Filter()
    {
        self.addFilterView()
    }
    
    func addFilterView()
    {
        
        filter.enabled = false
        SearchView.hidden = false
        
        imgLoadingBG.backgroundColor = UIColor(white: 0, alpha: 0.3)
        self.imgLoadingBG.hidden = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(MaidsSearchViewController.handleTap(_:)))
        imgLoadingBG.userInteractionEnabled = true
        imgLoadingBG.addGestureRecognizer(tap)
       
        SearchView.layer.cornerRadius = 5
        filterType = "code"
        
        rangeSlider.hidden = true
        
        switch Radio_Value
        {
        case 0 : btnCode.setImage(UIImage(named: "radio_active"), forState: .Normal)
                 btnType.setImage(UIImage(named: "radio_inactive"), forState: .Normal)
                 btnAge.setImage(UIImage(named: "radio_inactive"), forState: .Normal)
                 rangeSlider.hidden = true
        
                 break
            
        case 1 : btnCode.setImage(UIImage(named: "radio_inactive"), forState: .Normal)
                 btnType.setImage(UIImage(named: "radio_active"), forState: .Normal)
                 btnAge.setImage(UIImage(named: "radio_inactive"), forState: .Normal)
                 rangeSlider.hidden = true
        
                 break
            
        case 2 : btnCode.setImage(UIImage(named: "radio_inactive"), forState: .Normal)
                 btnType.setImage(UIImage(named: "radio_inactive"), forState: .Normal)
                 btnAge.setImage(UIImage(named: "radio_active"), forState: .Normal)
                 rangeSlider.hidden = false
        
                 break
            
        default : break
        }
        
        
        rangeSlider.setRange(20, maxRange: 80, accuracy: 1)
        rangeSlider.valueChangeClosure = {
            (left, right) -> () in
            print("left = \(left)  right = \(right) \n")
            self.fromAge = left
            self.toAge = right
            
        }
        SearchView.addSubview(rangeSlider)

        
        
        imgCode.backgroundColor = UIColor.lightGrayColor()
        imgType.backgroundColor = UIColor.lightGrayColor()
        
        btnOK.backgroundColor = UIColor(red: 129.0/255.0, green: 194.0/255.0, blue: 77.0/255.0, alpha: 1.0 )
        btnOK.layer.cornerRadius = 5
        
    }
    
    @IBAction func onClickRadio (sender : AnyObject)
    {
        if sender.tag == 0
        {
            btnCode.setImage(UIImage(named: "radio_active"), forState: .Normal)
            btnType.setImage(UIImage(named: "radio_inactive"), forState: .Normal)
            btnAge.setImage(UIImage(named: "radio_inactive"), forState: .Normal)
            filterType = "code"
            rangeSlider.hidden = true
            
        }
        else if sender.tag == 1
        {
         
            btnCode.setImage(UIImage(named: "radio_inactive"), forState: .Normal)
            btnType.setImage(UIImage(named: "radio_active"), forState: .Normal)
            btnAge.setImage(UIImage(named: "radio_inactive"), forState: .Normal)
            filterType = "type"
            rangeSlider.hidden = true
            
        }
        else
        {
            btnCode.setImage(UIImage(named: "radio_inactive"), forState: .Normal)
            btnType.setImage(UIImage(named: "radio_inactive"), forState: .Normal)
            btnAge.setImage(UIImage(named: "radio_active"), forState: .Normal)
            filterType = "age"
            rangeSlider.hidden = false
            
        }
    }
    
    
    @IBAction func ClickOK(sender: AnyObject)
    {
        if filterType == "code"
        {
            searchBar.placeholder = "search by code"
            imgLoadingBG.hidden = true
            
        }
        else if filterType == "type"
        {
            searchBar.placeholder = "search by type"
            imgLoadingBG.hidden = true
            
        }
        else
        {
            self.showLoading()
            self.performSelector(#selector(MaidsSearchViewController.filterMaid), withObject: nil, afterDelay: 1.0)

        }
        filter.enabled = true
        
        rangeSlider.removeFromSuperview()
        SearchView.hidden = true
        
    }
    func handleTap(sender : UITapGestureRecognizer)
    {
        filter.enabled = true
        
        SearchView.hidden = true
        imgLoadingBG.hidden = true
    }
    func goBack()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
 
    
    func showLoading ()
    {
        imgLoadingBG.backgroundColor = UIColor(white: 1, alpha: 0.8)
        
        
        activityView.hidden = false
        imgLoadingBG.hidden = false
        lblLoading.hidden = false
        
        activityView.startAnimating()
        
        
    }
    func hideLoading ()
    {
        activityView.hidden = true
        imgLoadingBG.hidden = true
        lblLoading.hidden = true
        
        activityView.stopAnimating()
        
        
    }
    
 

    func getOtherMaids()
    {
        let api : DataModel = DataModel()
        let DataDict = api.getAllMaids("http://innomaid.com.sg/api/v1/maids?api_token=m28lA7A5wrDrRo51o8MzEcIe7DDba406KVjcy8AcShgAmyU0&page="+String(index))
        
        print(DataDict)
        let paths = NSSearchPathForDirectoriesInDomains(
            NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.AllDomainsMask, true)
        let documentsDirectory = paths.first! as NSString
        
        let filePath = documentsDirectory.stringByAppendingPathComponent("OtherMaid_"+String(index)+".json")
        
        
        
        if (DataDict["data"] != nil && DataDict["data"]?.count != 0)
        {
            self.writeFile(filePath, inputStream: DataDict)
            
            self.hideLoading()
            
            
        }
      
        do
        {
            let filePath =
                documentsDirectory.stringByAppendingPathComponent("OtherMaid_"+String(self.index)+".json")
            
            
            let data : NSData = try NSData(contentsOfFile: filePath, options: NSDataReadingOptions.DataReadingMapped)
            
            let data_dict = try NSJSONSerialization.JSONObjectWithData(data, options:.AllowFragments) as! NSDictionary
            
            if (data_dict["data"] != nil)
            {
                var Data_Array : NSMutableArray = NSMutableArray()
                Data_Array = (data_dict["data"] as! NSArray).mutableCopy() as! NSMutableArray
                
                for var dict_maids in Data_Array
                {
                    
                    self.Maid_Array.addObject(dict_maids)
                }
                
            }
            print(Maid_Array)
            self.hideLoading()
            self.refreshControl.endRefreshing()
            
            
            
        }catch let jsonError as NSError {
            print(jsonError.localizedDescription)
        }
        tblMaids.reloadData()
        
    }
    
    func getMaid()
    {
        
        print("in getmaid", countryID)
        let api : DataModel = DataModel()
            let DataDict = api.getAllMaids("http://innomaid.com.sg/api/v1/maids?api_token=wcQbUTMMx7xPsqD0wTkjTA1hBMCOtFu93pFqJPmsB9n2xVSv&page="+String(index))
        
            let paths = NSSearchPathForDirectoriesInDomains(
                NSSearchPathDirectory.DocumentDirectory,
                NSSearchPathDomainMask.AllDomainsMask, true)
            let documentsDirectory = paths.first! as NSString
        
            let filePath = documentsDirectory.stringByAppendingPathComponent("Maid_"+String(index)+".json")
        
        
       
            if (DataDict["data"] != nil)
            {
                self.writeFile(filePath, inputStream: DataDict)
                
                self.hideLoading()
                
                
            }
            
            do
            {
                self.showLoading()
                let filePath =
                documentsDirectory.stringByAppendingPathComponent("Maid_"+String(self.index)+".json")
                
                
                let data : NSData = try NSData(contentsOfFile: filePath, options: NSDataReadingOptions.DataReadingMapped)
                
                let data_dict = try NSJSONSerialization.JSONObjectWithData(data, options:.AllowFragments) as! NSDictionary
                
                if (data_dict["data"] != nil)
                {
                    var Data_Array : NSMutableArray = NSMutableArray()
                    Data_Array = (data_dict["data"] as! NSArray).mutableCopy() as! NSMutableArray
                    
                    for var dict_maids in Data_Array
                    {
                        let country_dict = dict_maids["country"] as! NSDictionary
                        
                        
                            if (country_dict["data"] != nil)
                            {
                                let country_data_dict = country_dict["data"]
                                print("country id ", Int(country_data_dict!["id"] as! String))
                                
                                if Int(country_data_dict!["id"] as! String) == countryID
                                {
                                    
                                    self.Maid_Array.addObject(dict_maids)
                                    
                                     if Int(country_data_dict!["id"] as! String) == 11
                                    {
                                        
                                        if skill != "ALL HOUSEMAID"
                                        {
                                            
                                            print("In category")
                                            
                                            var predicate_title : NSPredicate = NSPredicate()
                                            var predicate_desc : NSPredicate = NSPredicate()
                                            let skill_dict = dict_maids["skill_set"] as! NSDictionary
                                            let skill_array =  (skill_dict["data"] as! NSArray).mutableCopy() as! NSMutableArray
                                            
                                            var skill_String = String()
                                            if skill == "NURSE AND CAREGIVER"
                                            {
                                                
                                                skill_String = "Care of elderly"
                                                
                                            }
                                            else
                                            {
                                                
                                                
                                                skill_String = "Care of infants/children"
                                                
                                                
                                            }
                                            predicate_title = NSPredicate(format: "ANY %K.%K.%K contains[c] %@","skill_set","data","workarea_title",skill_String)
                                            
                                            predicate_desc = NSPredicate(format: "ANY %K.%K.%K contains[c] %@","skill_set","data","workarea_description",skill_String)
                                            
                                            let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [predicate_title,predicate_desc])
                                            
                                            print(Maid_Array)
                                            searchResults = [Maid_Array.filteredArrayUsingPredicate(predicate)]
                                            
                                            Maid_Array = searchResults[0].mutableCopy() as! NSMutableArray
                                            
                                        }
                                    }
                                   
                                }
                                
                           
                               
                            }
                        
                    }
                    
                }
               print(Maid_Array)
                self.hideLoading()
                self.refreshControl.endRefreshing()
                
                
                
            }catch let jsonError as NSError {
                print(jsonError.localizedDescription)
            }
                tblMaids.reloadData()
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let maid_cell = tableView.dequeueReusableCellWithIdentifier("MaidCell") as! MaidTableViewCell
        var maid_dict = NSDictionary ()
        
       
            if insearchBar == true
            {
                maid_dict  = Result[indexPath.row] as! NSDictionary
            }
            else
            {
                maid_dict  = Maid_Array[indexPath.row] as! NSDictionary
                
            }
        
        
        if (maid_dict["profile_picture"] as? String) != nil
        {
            maid_cell.imgProfile .setImageURLString(maid_dict["profile_picture"] as! String)
            
            
        }
        else
        {
            maid_cell.imgProfile.image = UIImage(named: "placeholder.jpg")
        }
      
        
        
        maid_cell.lblName.text = maid_dict["name"] as! String
        maid_cell.lblName.font = UIFont(name: "Roboto-Medium", size: 15.0)
        
        maid_cell.lblType.text = "Type :" + (maid_dict["type"] as! String)
        maid_cell.lblType.font = UIFont(name: "Roboto-Regular", size: 15.0)
        
        maid_cell.lblCode.text = "Code :" + (maid_dict["reference_code"] as! String)
        maid_cell.lblCode.font = UIFont(name: "Roboto-Regular", size: 15.0)
        
        let age = maid_dict["age"] as! Int
        maid_cell.lblAge.text = "Age : " + String (age)
        maid_cell.lblAge.font = UIFont(name: "Roboto-Regular", size: 15.0)
        
       
        maid_cell.lblBirth.text = "Birth :" + (maid_dict["date_of_birth"] as! String)
        maid_cell.lblBirth.font = UIFont(name: "Roboto-Regular", size: 15.0)
        
        let national = maid_dict["country"] as! NSDictionary
        let national_data = national["data"] as! NSDictionary
        maid_cell.lblNation.text = "Nationality :" + (national_data["nationality"] as! String)
        maid_cell.lblNation.font = UIFont(name: "Roboto-Regular", size: 15.0)
        
        
        
        maid_cell.btnDownload.backgroundColor = UIColor(red: 25.0/255.0, green: 130.0/255.0, blue: 68.0/255.0, alpha: 1.0)
        maid_cell.btnDownload.layer.cornerRadius = 5
        maid_cell.btnDownload.tag = indexPath.row
        
        maid_cell.imgSp.backgroundColor = UIColor.lightGrayColor()
        
    
        self.HideKeyboard()
        maid_cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return maid_cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
            if insearchBar == true
            {
                return Result.count
            }
            else
            {
                return Maid_Array.count
            }
        
       
        

       
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
         var maid_dict = NSDictionary()
       
            if insearchBar == true
            {
                maid_dict = Result[indexPath.row] as! NSDictionary
                
                
            }
            else
            {
                maid_dict = Maid_Array[indexPath.row] as! NSDictionary
                
            }
        
       
        
        let board : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let  vc = board.instantiateViewControllerWithIdentifier("MaidDetail") as! MaidDetailViewController
        vc.Maid_Detail = maid_dict
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        print(filterType)
    
        self.showLoading()
        self.performSelector(#selector(MaidsSearchViewController.filterMaid), withObject: nil, afterDelay: 1.0)
    }
    
    func filterMaid()
    {
        self.filter_url()
        let reachability = Reachability.reachabilityForInternetConnection()
        let networkStatus = reachability.currentReachabilityStatus()
        
        if  (networkStatus == NotReachable)
        {
            var resultPredicate : NSPredicate = NSPredicate()
            if filterType == "code"
            {
               
                
                resultPredicate = NSPredicate(format: "reference_code contains[c] %@", searchBar.text!)
                
                
            }
            else if filterType == "type"
            {
               
                resultPredicate = NSPredicate(format: "type contains [c] %@", searchBar.text!)
                
                
            }
            else
            {
                resultPredicate = NSPredicate(format: "age BETWEEN {%d,%d}", fromAge,toAge)
                
            }
            
            self.HideKeyboard()
            
            insearchBar = true
            
            searchResults = [Maid_Array.filteredArrayUsingPredicate(resultPredicate)]
            Result = searchResults [0].mutableCopy() as! NSMutableArray
            
            
        }
        else
        {
            
            if filterType == "code"
            {
                url_filter = url_filter+"&reference_code="+searchBar.text!
                
            }
            
            else if filterType == "type"
            {
                url_filter = url_filter+"&type="+searchBar.text!
                
            }
            else
            {
                url_filter = url_filter+"&ageFrom="+String(fromAge)+"&ageTo="+String(toAge)
            }
            
            let api : DataModel = DataModel()
            
            let DataDict = api.getAllMaids(url_filter)
            print(url_filter)
            print(DataDict)
            Maid_Array = (DataDict["data"] as! NSArray).mutableCopy() as! NSMutableArray
        }
        
        tblMaids.reloadData()
        self.hideLoading()

    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        insearchBar = false
        return true
    }
    
    func HideKeyboard()
    {
        insearchBar = false
       // searchBar.resignFirstResponder()
        
    }
    
   
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        insearchBar = false
        searchBar.resignFirstResponder()
    }
    
    
    
    
    
    ////////////////////////////////// Write File /////////////////////////
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
   
    @IBAction func onClickDownload(sender: UIButton)
    {
        
      
        let indexpath = NSIndexPath(forRow: sender.tag, inSection: 0)
        let dictionary = Maid_Array[indexpath.row] as! NSDictionary
        
        let maid_id = dictionary["id"] as! Int
        let agency = dictionary["agency"] as! NSDictionary
        let agency_Data = agency["data"] as! NSDictionary
        let agency_id = agency_Data["id"] as! String
        
        let urlString = "http://innomaid.com.sg/api/getmaidpdf/?maid="+String(maid_id)+"&agency="+agency_id
        
       var docURL = (NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)).last
        let name = dictionary["name"]?.stringByReplacingOccurrencesOfString(" ", withString: "")
        docURL = docURL?.URLByAppendingPathComponent( name! + ".pdf")
        
        //var documentURL : String = String()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            
            let api : DataModel = DataModel()
            let theData : NSData = api.downloadingPDF(urlString)
            
            //Get the local docs directory and append your local filename.
            
            //Lastly, write your file to the disk.
            theData.writeToURL(docURL!, atomically: true)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                print("This is run on the main queue, after the previous code in outer block")
                let fileManager = NSFileManager()
                
                if fileManager.fileExistsAtPath((docURL?.path)!)
                {
                    let alert = UIAlertController(title: "Information", message: "Your maid's profile successfully downloaded!", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: {
                        action in
                        
                    }))
                   // self.presentViewController(alert, animated: true, completion: nil)
                }
            
                print(docURL)
                let destinationUrl = docURL
                
                  self.docController = UIDocumentInteractionController(URL: destinationUrl!)

                let url = NSURL(string:"itms-books://");
                
                if UIApplication.sharedApplication().canOpenURL(url!) {
                    
                    self.docController.presentOpenInMenuFromRect(CGRectZero, inView: self.view, animated: true)
                    
                    
                    print("iBooks is installed")
                    
                }else{
                    
                    print("iBooks is not installed")
                    
                   
                }
                
                
              
                
            })
            
            
        })
 
        
    }
    
    
    
    
    func filterContentForSearchText (searchText : String, scope: String) -> Void
    {
        let resultPredicate : NSPredicate = NSPredicate(format: "SELF contains [cd] ", searchText)
        searchResults = [Maid_Array .filteredArrayUsingPredicate(resultPredicate)]
        
        
    }
    
   
    
    

    
  
      
    

    }

