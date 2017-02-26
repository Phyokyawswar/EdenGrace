//
//  DataModel.swift
//  MaidAgency
//
//  Created by Phyo Kyaw Swar on 1/2/17.
//  Copyright © 2017 PhyoKyawSwar. All rights reserved.
//

import UIKit

class DataModel: NSObject {

    func getReviewData(url_string : String)->NSMutableArray
    {
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: url_string)!)
        request.cachePolicy = .ReloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 20
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var urlResponse : NSURLResponse?
        var data_array:NSMutableArray = NSMutableArray()
        
        do
        {
            if let response1 : NSData = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &urlResponse)
            {
                
                data_array = try (NSJSONSerialization.JSONObjectWithData(response1, options:.AllowFragments)as! NSArray).mutableCopy() as! NSMutableArray
              print(data_array)
            }
            
        }catch let jsonError as NSError {
            print(jsonError.localizedDescription)
        }
        
        
        return data_array
        
    }
    
    
    func getCountryData(url_string : String)->NSDictionary
    {
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: url_string)!)
        request.cachePolicy = .ReloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 20
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var urlResponse : NSURLResponse?
        var data_dict:NSDictionary = NSDictionary()
        
        do
        {
            if let response1 : NSData = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &urlResponse)
            {
                
                data_dict = try NSJSONSerialization.JSONObjectWithData(response1, options:.AllowFragments) as! NSDictionary
            }
            
        }catch let jsonError as NSError {
            print(jsonError.localizedDescription)
        }
        
        
        return data_dict
        
    }

    
    
    func postCustomerReview(reviewDict : NSDictionary ) ->NSDictionary
    {
        let json = reviewDict
        
        
        let data : NSData = NSKeyedArchiver.archivedDataWithRootObject(json)
        
        
        
        
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: "https://www.edengracemaids.com/customer-review-save/")!)
        request.cachePolicy = .ReloadIgnoringLocalAndRemoteCacheData
        request.HTTPMethod = "POST"
        request.timeoutInterval = 20
        request.HTTPBody = data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var response1:NSURLResponse?
        var data_dict:NSDictionary = NSDictionary()
        do
        {
            
            if let response : NSData = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response1)
            {
                data_dict = try NSJSONSerialization.JSONObjectWithData(response, options: .AllowFragments) as! NSDictionary
                
            }
        }catch let error as NSError
        {
            print(error.localizedDescription)
        }
        
        return data_dict

    }

    
    func getAllMaids(url_string : String)->NSDictionary
    {
        print(url_string)
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: url_string)!)
        request.cachePolicy = .ReloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 20
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var urlResponse : NSURLResponse?
        var data_dict:NSDictionary = NSDictionary()
        
        do
        {
            if let response1 : NSData = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &urlResponse)
            {
                
                data_dict = try NSJSONSerialization.JSONObjectWithData(response1, options:.AllowFragments) as! NSDictionary
               
            }
            
        }catch let jsonError as NSError {
            print(jsonError.localizedDescription)
        }
        
        
        return data_dict
        
    }
    
    
    func downloadingPDF(url_string : String) -> NSData
    {
        print(url_string)
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: url_string)!)
        request.cachePolicy = .ReloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 20
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var urlResponse : NSURLResponse?
        var data_dict:NSDictionary = NSDictionary()
        var response1 : NSData = NSData()
        do
        {
              response1 = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &urlResponse)
           
            
        }catch let jsonError as NSError {
            print(jsonError.localizedDescription)
        }
        
        return response1
        
        

    }
    
    
    func postEnquiry (enquiryDict : NSDictionary) -> NSDictionary
    {
        let json = enquiryDict
        
        
        let data : NSData = NSKeyedArchiver.archivedDataWithRootObject(json)
        
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: "https://www.edengracemaids.com/send-customers-email/")!)
        request.cachePolicy = .ReloadIgnoringLocalAndRemoteCacheData
        request.HTTPMethod = "POST"
        request.timeoutInterval = 20
        request.HTTPBody = data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var response1:NSURLResponse?
        var data_dict:NSDictionary = NSDictionary()
        do
        {
            
            if let response : NSData = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response1)
            {
                data_dict = try NSJSONSerialization.JSONObjectWithData(response, options: .AllowFragments) as! NSDictionary
                
            }
        }catch let error as NSError
        {
            print(error.localizedDescription)
        }
        
        return data_dict
        

    }
    
   
}
