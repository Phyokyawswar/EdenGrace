//
//  ContactUsViewController.swift
//  MaidAgency
//
//  Created by Phyo Kyaw Swar on 10/2/17.
//  Copyright © 2017 PhyoKyawSwar. All rights reserved.
//

import UIKit
import MapKit

class ContactUsViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblCompanyNameValue: UILabel!
    @IBOutlet weak var lblCompanyPhone: UILabel!
    @IBOutlet weak var lblCompanyPhoneValue: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblAddressValue: UILabel!
    
    @IBOutlet weak var menuButton:UIBarButtonItem!
    
    @IBOutlet var mapView: MKMapView!
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
        
        lblCompanyName.text = "Company Name"
        lblCompanyName.font = UIFont(name: "Roboto-Medium", size: 15.0)
        lblCompanyNameValue.text = "Eden Grace"
        lblCompanyNameValue.font =  UIFont(name: "Roboto-Light", size: 15.0)
        
        lblCompanyPhone.text = "Phone"
        lblCompanyPhone.font = UIFont(name: "Roboto-Medium", size: 15.0)
        lblCompanyPhoneValue.text = "Office: +65 62625562, Chris Wong @ 91187703, Julie Rose @ 98568387 or Susan Lee @ 83891511"
        lblCompanyPhoneValue.font =  UIFont(name: "Roboto-Light", size: 15.0)
        

        lblAddress.text = "Address"
        lblAddress.font = UIFont(name: "Roboto-Medium", size: 15.0)
        lblAddressValue.text = "Blk. 18 Sin Ming Lane, #07-38 Midview City, Singapore 573960"
        lblAddressValue.font =  UIFont(name: "Roboto-Light", size: 15.0)
        
        
        let location: String = "Blk. 18 Sin Ming Lane, #07-38 Midview City, Singapore 573960"
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.geocodeAddressString(location,completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            if (placemarks?.count > 0) {
                let topResult: CLPlacemark = (placemarks?[0])!
                let placemark: MKPlacemark = MKPlacemark(placemark: topResult)
                var region: MKCoordinateRegion = self.mapView.region
                
                region.center.latitude = (placemark.location?.coordinate.latitude)!
                region.center.longitude = (placemark.location?.coordinate.longitude)!
                
                region.span = MKCoordinateSpanMake(0.01, 0.01)
                
                self.mapView.setRegion(region, animated: true)

                self.mapView.addAnnotation(placemark)
            }
        })
       

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
