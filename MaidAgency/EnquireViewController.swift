//
//  EnquireViewController.swift
//  MaidAgency
//
//  Created by Phyo Kyaw Swar on 10/2/17.
//  Copyright © 2017 PhyoKyawSwar. All rights reserved.
//

import UIKit

class EnquireViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var btnSend: UIButton!
    
    
    @IBOutlet weak var menuButton:UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nav = customNav()
        self.navigationItem.titleView = nav.navTitle()
        
        if revealViewController() != nil
        {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }

        let BDtextField : CALayer = CALayer()
        BDtextField.frame = CGRectMake(0.0, txtName.frame.size.height - 1, txtName.frame.size.width, 1.0)
        BDtextField.backgroundColor = UIColor(red: 129.0/255.0, green: 194.0/255.0, blue: 77.0/255.0, alpha: 1.0 ).CGColor
        txtName.layer.addSublayer(BDtextField)

        let BDtextField1 : CALayer = CALayer()
        BDtextField1.frame = CGRectMake(0.0, txtEmail.frame.size.height - 1, txtEmail.frame.size.width, 1.0)
        BDtextField1.backgroundColor = UIColor(red: 129.0/255.0, green: 194.0/255.0, blue: 77.0/255.0, alpha: 1.0 ).CGColor
        txtEmail.layer.addSublayer(BDtextField1)
        

        let BDtextField2 : CALayer = CALayer()
        BDtextField2.frame = CGRectMake(0.0, txtPhone.frame.size.height - 1, txtPhone.frame.size.width, 1.0)
        BDtextField2.backgroundColor = UIColor(red: 129.0/255.0, green: 194.0/255.0, blue: 77.0/255.0, alpha: 1.0 ).CGColor
        txtPhone.layer.addSublayer(BDtextField2)
       
        let BDtextField3 : CALayer = CALayer()
        BDtextField3.frame = CGRectMake(0.0, txtMessage.frame.size.height - 1, txtMessage.frame.size.width, 1.0)
        BDtextField3.backgroundColor = UIColor(red: 129.0/255.0, green: 194.0/255.0, blue: 77.0/255.0, alpha: 1.0 ).CGColor
        txtMessage.layer.addSublayer(BDtextField3)
        
        btnSend.backgroundColor = UIColor(red: 129.0/255.0, green: 194.0/255.0, blue: 77.0/255.0, alpha: 1.0 )
        btnSend.layer.cornerRadius = 5
        
        txtName.placeholder = "Enter your Name *"
        txtPhone.placeholder = "Enter your Phone *"
        txtEmail.placeholder = "Enter your Email *"
        txtMessage.text = "Message"
        txtMessage.textColor = UIColor.lightGrayColor()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickSend (sender : AnyObject)
    {
        if txtName.text != "" && txtEmail.text != "" && txtPhone.text != "" && txtMessage.text != ""
        {
            if self.validateEmail(txtEmail.text!)
            {
               
                let dict = ["maid_name":"","enqurier_name":txtName.text,"enqurier_contact":txtPhone.text,"enqurier_email":txtEmail.text,"message":txtMessage.text]
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
    
    @IBAction func textFieldDidEndEditing(textField: UITextField) {
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 548)
        
        textField.resignFirstResponder()
    }
    
    @IBAction func textFieldShouldEndEditing(textField: UITextField) {
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 548)
        
        textField.resignFirstResponder()
        
        
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width , 800)
        
        txtMessage.text = ""
        return true
        
    }
    
    func textViewDidChange(textView: UITextView) {
        if let text = textView.text where text.isEmpty
        {
            //do something if it's not empty
            print("empty text view")
            text.characters.count
            txtMessage.text = "Message"
            txtMessage.resignFirstResponder()
            
        }
       
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"
        {
            scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 450)
            
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
    
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
