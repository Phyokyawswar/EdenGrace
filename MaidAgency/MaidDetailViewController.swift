//
//  MaidDetailViewController.swift
//  MaidAgency
//
//  Created by Phyo Kyaw Swar on 6/2/17.
//  Copyright © 2017 PhyoKyawSwar. All rights reserved.
//

import UIKit

class MaidDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIDocumentInteractionControllerDelegate {
    
    var Maid_Detail : NSDictionary!
    var SkillArray : NSMutableArray!
    var workarea_title_array : NSMutableArray = NSMutableArray()
    
    var docController : UIDocumentInteractionController!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var AboutView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnDown: UIButton!
    
    @IBOutlet weak var lblHeightValue: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblWeightValue: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblRestDayValue: UILabel!
    @IBOutlet weak var lblRestDay: UILabel!
    @IBOutlet weak var lblMerriedStatusValue: UILabel!
    @IBOutlet weak var lblMarriedStatus: UILabel!
    @IBOutlet weak var lblPlaceofBirthValue: UILabel!
    @IBOutlet weak var lblPlaceofBirth: UILabel!
    @IBOutlet weak var lblNationalityValue: UILabel!
    @IBOutlet weak var lblNationality: UILabel!
    @IBOutlet weak var lblAgeValue: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblChildrenValue: UILabel!
    @IBOutlet weak var lblChildren: UILabel!
    @IBOutlet weak var lblSiblingsValue: UILabel!
    @IBOutlet weak var lblSibilings: UILabel!
    @IBOutlet weak var lblBirthValue: UILabel!
    @IBOutlet weak var lblBirth: UILabel!
    @IBOutlet weak var lblAvailabilityValue: UILabel!
    @IBOutlet weak var lblAvailability: UILabel!
    @IBOutlet weak var lblEducationValue: UILabel!
    @IBOutlet weak var lblEducation: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblCodeValue: UILabel!
    @IBOutlet weak var lblSalaryValue: UILabel!
    @IBOutlet weak var lblSalary: UILabel!
    @IBOutlet weak var lblTypeValue: UILabel!
    @IBOutlet weak var lblType: UILabel!
    
    
    @IBOutlet weak var SkillView: UIView!
    @IBOutlet weak var tblSkill: UITableView!
    @IBOutlet weak var lblPreference: UILabel!
    
    @IBOutlet weak var IntroView: UIView!
    @IBOutlet weak var WebIntro: UIWebView!
    
    @IBOutlet weak var EnquireView: UIView!
    @IBOutlet weak var EnquireScroll: UIScrollView!
    @IBOutlet weak var lblEnquireName: UILabel!
    @IBOutlet weak var txtEnquireName: UITextField!
    @IBOutlet weak var lblEnquirerName: UILabel!
    @IBOutlet weak var txtEnquirerName: UITextField!
    @IBOutlet weak var lblEnquirerContact: UILabel!
    @IBOutlet weak var txtEnquirerContact: UITextField!
    @IBOutlet weak var lblEnquirerEmail: UILabel!
    @IBOutlet weak var txtEnquirerEmail: UITextField!
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var btnEnqury: UIButton!
    @IBOutlet weak var btnShowEnquire: UIButton!
    @IBOutlet weak var imgBG: UIImageView!
  
    @IBOutlet weak var imgRating5: UIImageView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Maid_Detail)
        
        let nav = customNav()
        self.navigationItem.titleView = nav.navTitle()
        
        
        
        let btnBack = UIBarButtonItem()
        btnBack.action = #selector(MaidDetailViewController.goBack)
        btnBack.target = self
        btnBack.image = UIImage(named: "white_arrow")
        self.navigationItem.leftBarButtonItem = btnBack
        
        
        if (Maid_Detail["profile_picture"] as? String) != nil
        {
            imgProfile .setImageURLString(Maid_Detail["image"] as! String)
        }
        else
        {
         imgProfile.image = UIImage(named: "placeholder.jpg")
        }
        
        lblName.text = Maid_Detail ["name"] as! String
        lblName.font = UIFont(name: "Roboto-Medium", size: 18.0)
        lblName.textColor = UIColor.blackColor()

        lblType.text = "Type"
        lblType.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblType.textColor = UIColor.grayColor()
        
        lblSalary.text = "Salary"
        lblSalary.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblSalary.textColor = UIColor.grayColor()
        
        lblCode.text = "Code"
        lblCode.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblCode.textColor = UIColor.grayColor()
        
        lblEducation.text = "Education"
        lblEducation.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblEducation.textColor = UIColor.grayColor()
        
        lblAvailability.text = "Availability"
        lblAvailability.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblAvailability.textColor = UIColor.grayColor()
        
        lblBirth.text = "Date of Birth"
        lblBirth.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblBirth.textColor = UIColor.grayColor()
        
        lblSibilings.text = "Sibilings"
        lblSibilings.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblSibilings.textColor = UIColor.grayColor()
        
        lblChildren.text = "Children"
        lblChildren.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblChildren.textColor = UIColor.grayColor()
        
        lblAge.text = "Age"
        lblAge.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblAge.textColor = UIColor.grayColor()
        
        lblNationality.text = "Nationality"
        lblNationality.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblNationality.textColor = UIColor.grayColor()
        
        lblPlaceofBirth.text = "Place of Birth"
        lblPlaceofBirth.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblPlaceofBirth.textColor = UIColor.grayColor()
        
        lblMarriedStatus.text = "Married Status"
        lblMarriedStatus.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblMarriedStatus.textColor = UIColor.grayColor()
        
        lblRestDay.text = "Rest day per preference"
        lblRestDay.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblRestDay.textColor = UIColor.grayColor()
        
        lblWeight.text = "Weight"
        lblWeight.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblWeight.textColor = UIColor.grayColor()
        
        lblHeight.text = "Height"
        lblHeight.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblHeight.textColor = UIColor.grayColor()
        
        
       
        lblTypeValue.text = Maid_Detail["type"] as? String
        lblTypeValue.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblTypeValue.textColor = UIColor.grayColor()
        
        lblSalaryValue.text = Maid_Detail["expected_salary"] as! String
        lblSalaryValue.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblSalaryValue.textColor = UIColor.grayColor()
        
        lblCodeValue.text = Maid_Detail["reference_code"] as! String
        lblCodeValue.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblCodeValue.textColor = UIColor.grayColor()
        
        let Education = Maid_Detail["education"] as! NSDictionary
        let Edu_Data = Education["data"] as! NSDictionary
        
        lblEducationValue.text = Edu_Data["description"] as! String
        lblEducationValue.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblEducationValue.textColor = UIColor.grayColor()
        
        lblAvailabilityValue.text = Maid_Detail["availability"] as! String
        lblAvailabilityValue.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblAvailabilityValue.textColor = UIColor.grayColor()
        
        lblBirthValue.text = Maid_Detail["date_of_birth"] as! String
        lblBirthValue.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblBirthValue.textColor = UIColor.grayColor()
        
        let sibilings = Maid_Detail["no_of_siblings"] as! Int
        lblSiblingsValue.text = String(sibilings)
        lblSiblingsValue.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblSiblingsValue.textColor = UIColor.grayColor()
        
        let children = Maid_Detail["no_of_children"] as! Int
        
        lblChildrenValue.text = String(children)
        lblChildrenValue.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblChildrenValue.textColor = UIColor.grayColor()
        
        let age = Maid_Detail["age"] as! Int
        
        lblAgeValue.text = String(age)
        lblAgeValue.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblAgeValue.textColor = UIColor.grayColor()
        
        let country = Maid_Detail["country"] as! NSDictionary
        let country_Data = country["data"] as! NSDictionary
        
        lblNationalityValue.text = country_Data["nationality"] as! String
        lblNationalityValue.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblNationalityValue.textColor = UIColor.grayColor()
        
        lblPlaceofBirthValue.text = Maid_Detail["place_of_birth"] as! String
        lblPlaceofBirthValue.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblPlaceofBirthValue.textColor = UIColor.grayColor()
        
        lblMerriedStatusValue.text = Maid_Detail["marital_status"] as! String
        lblMerriedStatusValue.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblMerriedStatusValue.textColor = UIColor.grayColor()
        
        let rest = Maid_Detail["rest_days_preference"] as! Int
        lblRestDayValue.text = String(rest)
        lblRestDayValue.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblRestDayValue.textColor = UIColor.grayColor()
        
        let weight = Maid_Detail["weight"] as! Int
        lblWeightValue.text = String(weight) + "Kg"
        lblWeightValue.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblWeightValue.textColor = UIColor.grayColor()
        
        let height = Maid_Detail["height"] as! Int
        lblHeightValue.text = String(height) + "cm"
        lblHeightValue.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblHeightValue.textColor = UIColor.grayColor()
        

        
        let skill_dict = Maid_Detail["skill_set"] as! NSDictionary
        SkillArray = (skill_dict["data"] as! NSArray).mutableCopy() as! NSMutableArray
        
        var title_array : NSMutableArray = NSMutableArray()
        
       for var skill_dict in SkillArray
       {
        
        if skill_dict["interview_type"] as! String == "Overseas EA" && skill_dict["experience"] as! Bool == true
        {
            workarea_title_array.addObject(skill_dict)
        }
       
       
        }
        
        
        lblPreference.text = "Preference"
        lblPreference.font = UIFont(name: "Roboto-Regular", size: 15.0)
        lblPreference.textColor = UIColor.grayColor()
        
        
        WebIntro.loadHTMLString(Maid_Detail["intro"] as! String, baseURL: nil)
       
        self.performSelector(#selector(MaidDetailViewController.setScrollSize), withObject: nil, afterDelay: 1.0)
        
        EnquireView.hidden = true
       
        // Do any additional setup after loading the view.
    }
    
    func setScrollSize()
    {
        scrollView.contentSize = CGSizeMake(320, 850)
    }
    
    func goBack()
    {
        self.navigationController?.popViewControllerAnimated(true)  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workarea_title_array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let skill_cell = tableView.dequeueReusableCellWithIdentifier("SkillCell") as! SkillTableViewCell
        
       // let skill = workarea_title_array[indexPath.row] as! String
        let dictionary = workarea_title_array[indexPath.row] as! NSDictionary
        
        skill_cell.lblSkill.text = dictionary["workarea_title"] as! String
        skill_cell.lblSkill.font = UIFont(name: "Roboto-Light", size: 12.0)
        skill_cell.lblSkill.textColor = UIColor.grayColor()
        
        
        if  let rating = dictionary["rating"] as? NSNull
        {
            print(rating)
        }
        else
        {
            
            let rating : Int = Int(dictionary["rating"] as! String)!
            print("skill rating",rating)
            
            switch rating
            {
            case 1 : skill_cell.imgStar1.image = UIImage(named: "rating")
            skill_cell.imgStar2.image = UIImage(named: "rating_gray")
            skill_cell.imgStar3.image = UIImage(named: "rating_gray")
            skill_cell.imgStar4.image = UIImage(named: "rating_gray")
            skill_cell.imgStar5.image = UIImage(named: "rating_gray")
                break
                
            case 2 : skill_cell.imgStar1.image = UIImage(named: "rating")
            skill_cell.imgStar2.image = UIImage(named: "rating")
            skill_cell.imgStar3.image = UIImage(named: "rating_gray")
            skill_cell.imgStar4.image = UIImage(named: "rating_gray")
            skill_cell.imgStar5.image = UIImage(named: "rating_gray")
                break
                
            case 3 : skill_cell.imgStar1.image = UIImage(named: "rating")
            skill_cell.imgStar2.image = UIImage(named: "rating")
            skill_cell.imgStar3.image = UIImage(named: "rating")
            skill_cell.imgStar4.image = UIImage(named: "rating_gray")
            skill_cell.imgStar5.image = UIImage(named: "rating_gray")
                break
                
            case 4 : skill_cell.imgStar1.image = UIImage(named: "rating")
            skill_cell.imgStar2.image = UIImage(named: "rating")
            skill_cell.imgStar3.image = UIImage(named: "rating")
            skill_cell.imgStar4.image = UIImage(named: "rating")
            skill_cell.imgStar5.image = UIImage(named: "rating_gray")
                break
                
            case 5 : skill_cell.imgStar1.image = UIImage(named: "rating")
            skill_cell.imgStar2.image = UIImage(named: "rating")
            skill_cell.imgStar3.image = UIImage(named: "rating")
            skill_cell.imgStar4.image = UIImage(named: "rating")
            skill_cell.imgStar5.image = UIImage(named: "rating")
                break
                
            default : break
            }

            
        }
        
        skill_cell.selectionStyle = UITableViewCellSelectionStyle.None
        
              return skill_cell
    }
    
    @IBAction func SegmentClick(sender: AnyObject)
    {
        if segmentControl.selectedSegmentIndex == 0
        {
            AboutView.hidden = false
            SkillView.hidden = true
        }
        else if segmentControl.selectedSegmentIndex == 1
        {
            AboutView.hidden = true
            SkillView.hidden = false
        }
        else
        {
            AboutView.hidden = true
            SkillView.hidden = true
            IntroView.hidden = false
            
        }
    }
    
    
    @IBAction func onClickDownload(sender: UIButton)
    {
                
        let maid_id = Maid_Detail["id"] as! Int
        let agency = Maid_Detail["agency"] as! NSDictionary
        let agency_Data = agency["data"] as! NSDictionary
        let agency_id = agency_Data["id"] as! String
        
        let urlString = "http://innomaid.com.sg/api/getmaidpdf/?maid="+String(maid_id)+"&agency="+agency_id
        
        var docURL = (NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)).last
        let name = Maid_Detail["name"]?.stringByReplacingOccurrencesOfString(" ", withString: "")
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
    
    func removeDuplicates(array: [String]) -> [String] {
        var encountered = Set<String>()
        var result: [String] = []
        for value in array {
            if encountered.contains(value) {
                // Do not add a duplicate element.
            }
            else {
                // Add value to the set.
                encountered.insert(value)
                // ... Append the value.
                result.append(value)
            }
        }
        return result
    }
    @IBAction func onClickShowEnquire(sender: AnyObject)
    {
        self.showEnquireForm()
    }
    @IBAction func onClickEnquire(sender: AnyObject)
    {
        EnquireView.hidden = true
        imgBG.hidden = true
        
        if txtEnquirerName.text != "" && txtEnquirerEmail.text != "" && txtEnquirerContact.text != "" && txtMessage.text != ""
        {
            if self.validateEmail(txtEnquirerEmail.text!)
            {
                
                let dict = ["maid_name":"","enqurier_name":txtEnquirerName.text,"enqurier_contact":txtEnquirerContact.text,"enqurier_email":txtEnquirerEmail.text,"message":txtMessage.text]
                let api : DataModel = DataModel ()
                let dictionary = api.postEnquiry(dict)
                print(dictionary)
                
                let alert = UIAlertController (title: "Information", message: dictionary["Message"] as? String, preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: {
                    action in
                    
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        }
        else
        {
            let alert = UIAlertController (title: "Information", message: "Please enter all fields.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: {
                action in
                
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }
  
    func handleTap(sender : UITapGestureRecognizer)
    {
        EnquireView.hidden = true
        imgBG.hidden = true
        
    }
    
    
    
    func showEnquireForm()
    {
        EnquireView.hidden = false
        EnquireView.layer.cornerRadius = 5
        imgBG.hidden = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MaidDetailViewController.handleTap(_:)))
        imgBG.userInteractionEnabled = true
        imgBG.addGestureRecognizer(tap)
        
        imgBG.backgroundColor = UIColor(white: 0, alpha: 0.3)
        
        lblEnquireName.text = "Maid Name"
        lblEnquireName.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblEnquireName.textColor = UIColor.blackColor()
        
        lblEnquirerName.text = "Name *"
        lblEnquirerName.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblEnquirerName.textColor = UIColor.blackColor()
        
        lblEnquirerContact.text = "Phone No. *"
        lblEnquirerContact.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblEnquirerContact.textColor = UIColor.blackColor()
        
        lblEnquirerEmail.text = "Email *"
        lblEnquirerEmail.font = UIFont(name: "Roboto-Regular", size: 12.0)
        lblEnquirerEmail.textColor = UIColor.blackColor()
        
        txtEnquireName.text = Maid_Detail["name"] as! String
        txtEnquireName.userInteractionEnabled = false
        
        txtEnquirerName.placeholder = "Enter Name"
        txtEnquirerContact.placeholder = "Enter Phone no."
        txtEnquirerEmail.placeholder = "Enter Email"
        
        txtMessage.text = "Message"
        txtMessage.textColor = UIColor.lightGrayColor()

        
        let BDtextField : CALayer = CALayer()
        BDtextField.frame = CGRectMake(0.0, txtEnquireName.frame.size.height - 1, txtEnquireName.frame.size.width, 1.0)
        BDtextField.backgroundColor = UIColor(red: 129.0/255.0, green: 194.0/255.0, blue: 77.0/255.0, alpha: 1.0 ).CGColor
        txtEnquireName.layer.addSublayer(BDtextField)

        let BDtextField1 : CALayer = CALayer()
        BDtextField1.frame = CGRectMake(0.0, txtEnquirerContact.frame.size.height - 1, txtEnquirerContact.frame.size.width, 1.0)
        BDtextField1.backgroundColor = UIColor(red: 129.0/255.0, green: 194.0/255.0, blue: 77.0/255.0, alpha: 1.0 ).CGColor
        txtEnquirerContact.layer.addSublayer(BDtextField1)

        
        let BDtextField2 : CALayer = CALayer()
        BDtextField2.frame = CGRectMake(0.0, txtEnquirerEmail.frame.size.height - 1, txtEnquirerEmail.frame.size.width, 1.0)
        BDtextField2.backgroundColor = UIColor(red: 129.0/255.0, green: 194.0/255.0, blue: 77.0/255.0, alpha: 1.0 ).CGColor
        txtEnquirerEmail.layer.addSublayer(BDtextField2)
        
        let BDtextField3 : CALayer = CALayer()
        BDtextField3.frame = CGRectMake(0.0, txtEnquirerName.frame.size.height - 1, txtEnquirerName.frame.size.width, 1.0)
        BDtextField3.backgroundColor = UIColor(red: 129.0/255.0, green: 194.0/255.0, blue: 77.0/255.0, alpha: 1.0 ).CGColor
        txtEnquirerName.layer.addSublayer(BDtextField3)
      
        let BDtextField4 : CALayer = CALayer()
        BDtextField4.frame = CGRectMake(0.0, txtMessage.frame.size.height - 1, txtMessage.frame.size.width, 1.0)
        BDtextField4.backgroundColor = UIColor(red: 129.0/255.0, green: 194.0/255.0, blue: 77.0/255.0, alpha: 1.0 ).CGColor
        txtMessage.layer.addSublayer(BDtextField4)
        
        btnEnqury.layer.cornerRadius = 5.0
        
        
        
        
        
    }
    
    @IBAction func textFieldDidEndEditing(textField: UITextField) {
        EnquireScroll.contentSize = CGSizeMake(280, 450)
        
        textField.resignFirstResponder()
    }
    
    @IBAction func textFieldShouldEndEditing(textField: UITextField) {
        EnquireScroll.contentSize = CGSizeMake(280, 450)
        
        textField.resignFirstResponder()
        
        
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        
        EnquireScroll.contentSize = CGSizeMake(EnquireView.frame.size.width , 600)
        
        txtMessage.text = ""
        txtMessage.textColor = UIColor.lightGrayColor()
        return true
        
    }
    
    func textViewDidChange(textView: UITextView) {
        if textView.text.isEmpty
        {
            txtMessage.text = "Message"
            txtMessage.resignFirstResponder()
            
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"
        {
            EnquireScroll.contentSize = CGSizeMake(280, 450)
            
            textView.resignFirstResponder()
            return false
            
        }
        return true
        
    }
    
   
    func validateEmail (emailString : String ) -> Bool
    {
        if emailString.characters.count == 0
        {
            return false
        }
        
        let regExPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        var regExMatches : Int = Int()
        do
        {
            let regEx  = try NSRegularExpression(pattern: regExPattern, options: .CaseInsensitive)
            regExMatches  = regEx.numberOfMatchesInString(emailString, options: NSMatchingOptions.Anchored, range: NSMakeRange(0, emailString.characters.count))
            
        }catch let error as NSError {
            print(error.localizedDescription)
        }
        
        if regExMatches == 0
        {
            let alert = UIAlertController (title: "Information", message: "Please enter Email correctly", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: {
                action in
                
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
            
        }
        else
        {
            return true
        }
    }
    



   
}
