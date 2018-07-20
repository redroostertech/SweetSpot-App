//
//  UIView.swift
//  SweetSpot
//
//  Created by Iziah Reid on 7/19/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

extension UIView {
    /** Loads instance from nib with the same name. */
    func loadNib(myNibName:String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        //let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: myNibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}

