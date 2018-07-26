//
//  AutoCompleteAddressPopulator.swift
//  SweetSpot
//
//  Created by Iziah Reid on 7/24/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import Foundation
import Alamofire
import Foundation
import UIKit
import DropDown
class AutoCompleteAdddressPopulator{
    
    fileprivate var responseData:NSMutableData?
    fileprivate var dataTask:URLSessionDataTask?
    fileprivate let googleMapsKey = "AIzaSyCE-IICsrZpekbpWXj-v_7rtCR83-Dym50"
    fileprivate let baseURLString = "https://maps.googleapis.com/maps/api/place/autocomplete/json"
    
    var autoCompleteLocations = [String]()
    var autoCompleteView:UIView = UIView()
    var autoCompleteHandleTextChange:Bool = true
    
 
    
    public func fetchAutocompletePlaces( keyword:String, dropDown: DropDown) {
        let urlString = "\(baseURLString)?key=\(googleMapsKey)&input=\(keyword)"
        let s = (CharacterSet.urlQueryAllowed as NSCharacterSet).mutableCopy() as! NSMutableCharacterSet
        s.addCharacters(in: "+&")
        if let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: s as CharacterSet) {
            if let url = URL(string: encodedString) {
                let request = URLRequest(url: url)
                dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                    if let data = data{
                        
                        do{
                            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                            
                            if let status = result["status"] as? String{
                                if status == "OK"{
                                    if let predictions = result["predictions"] as? NSArray{
                                        //var locations = [String]()
                                        self.autoCompleteLocations = [String]()
                                        for dict in predictions as! [NSDictionary]{
                                            self.autoCompleteLocations.append(dict["description"] as! String)
                                        }
                                        DispatchQueue.main.async{
                                            dropDown.dataSource = self.autoCompleteLocations
                                            dropDown.show()
                                        }
                                        
                                        return
                                    }
                                }
                            }
                            
                        }
                        catch let error as NSError{
                            print("Error: \(error.localizedDescription)")
                        }
                    }
                })
                dataTask?.resume()
            }
        }
    }
    
}
