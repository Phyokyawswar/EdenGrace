//
//  MaidsCategoryViewController.swift
//  MaidAgency
//
//  Created by Phyo Kyaw Swar on 9/2/17.
//  Copyright © 2017 PhyoKyawSwar. All rights reserved.
//

import UIKit

class MaidsCategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var country_ID : Int = Int()
    
    let category_Array = ["ALL HOUSEMAID","NURSE AND CAREGIVER","NANNY AND INFANT CARE"]
    @IBOutlet weak var tblCategory: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nav = customNav()
        self.navigationItem.titleView = nav.navTitle()
        
        let btnBack = UIBarButtonItem()
        btnBack.action = #selector(MaidsCategoryViewController.goBack)
        btnBack.target = self
        btnBack.image = UIImage(named: "white_arrow")
        self.navigationItem.leftBarButtonItem = btnBack
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category_Array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     
        let table_cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell") as! SkillTableViewCell
        
        table_cell.lblSkill.text = category_Array[indexPath.row] 
        table_cell.lblSkill.font = UIFont (name: "Roboto-Regular", size: 12.0)
        
        table_cell.imgSp.backgroundColor = UIColor.lightGrayColor()
        
        table_cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return table_cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let board : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let  vc = board.instantiateViewControllerWithIdentifier("MaidsSearch") as! MaidsSearchViewController
        vc.countryID =  country_ID
        vc.skill = category_Array[indexPath.row] 
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func goBack()
    {
        self.navigationController?.popViewControllerAnimated(true)
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
