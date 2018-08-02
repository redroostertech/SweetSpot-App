//
//  Utils.swift
//  CheftHandedOwner
//
//  Created by Iziah Reid on 7/9/18.
//  Copyright © 2018 NuraCode. All rights reserved.
//

//
//  Utils.swift
//  HomeChatrDemo
//
//  Created by Iziah on 2/9/18.
//  Copyright © 2018 nuracode. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation
//delete placeholder text from Comments on Instructions panel
class Utils{
    
    
    public func savePermanentString( keyName: String, keyValue: String){
        print("setting internally: \(keyName) as \(keyValue)")
        UserDefaults.standard.set(keyValue, forKey: keyName)
    }
    
    public func getPermanentString( keyName: String ) -> String{
        print("getting \(keyName)")
        var userIDString =  UserDefaults.standard.object(forKey: keyName)
        if userIDString == nil{
            userIDString = ""
        }
        print("\(userIDString!)")
        return userIDString  as! String
    }
    
    
    public func getDateFromString(strDate:String) -> Date{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: strDate)
        return date!
    }
    
    public func getStringFromDate(dateStr:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let newDate = dateFormatter.string(from: dateStr)
        return newDate
    }
    
    
    
    
    public func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    
    public func DeleteIfExists(path: NSURL) -> Bool {
        var deleted = true
        // var error: NSError?
        if (FileManager.default.fileExists(atPath: path.path!)) {
            do{
                try FileManager.default.removeItem(atPath: path.path!)
            }catch{
                deleted = false
            }
        }
        return deleted
    }
    
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
}

