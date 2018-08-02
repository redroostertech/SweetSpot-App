//
//  UIImageView.swift
//  HomeChatr
//
//  Created by i5 pro on 12/19/17.
//  Copyright © 2017 NuraCode. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache <AnyObject,AnyObject>()
extension UIImageView {
    public func outlineImage(sender: UIImageView, outlineColor: UIColor, outlineWidth: Int) {
        sender.layer.borderColor = outlineColor.cgColor
        sender.layer.borderWidth = CGFloat(outlineWidth)
    }
    
    public func circularImage(sender: UIImageView){
        sender.layer.cornerRadius = sender.frame.height / 2
        sender.clipsToBounds = true
    }
    
    public func maskCircle(anyImage: UIImage) {
        //        self.contentMode = UIViewContentMode.scaleAspectFill
        //        self.layer.cornerRadius = self.frame.height / 2
        //        self.layer.masksToBounds = false
        //        self.clipsToBounds = true
        //
        //        // make square(* must to make circle),
        //        // resize(reduce the kilobyte) and
        //        // fix rotation.
        //        self.image = anyImage.squareImage()
        self.image = anyImage.circleMasked
    }
    public func imageFromUrl(theUrl: String) {
        self.image = nil
        
        //check cache for image
        if let cachedImage = imageCache.object(forKey: theUrl as AnyObject) as? UIImage{
            self.image = cachedImage
            return
        }
        
        //otherwise download it
        let url = URL(string: theUrl)
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            
            //print error
            if (error != nil){
                print(error!)
                return
            }
            
            DispatchQueue.main.async(execute: {
                if let downloadedImage = UIImage(data: data!){
                    imageCache.setObject(downloadedImage, forKey: theUrl as AnyObject)
                    self.image = downloadedImage
                }
            })
            
        }).resume()
    }
}

