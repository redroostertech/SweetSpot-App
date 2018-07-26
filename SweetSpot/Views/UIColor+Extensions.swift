//
//  Colors.swift
//  PopViewers
//
//  Created by Michael Westbrooks on 3/17/18.
//  Copyright © 2018 MVPGurus. All rights reserved.
//

import UIKit

extension UIColor {
    struct AppColors {
        static var beige = UIColor(red: 255/255, green: 250/255, blue: 238/255, alpha: 1)
        static var black = UIColor(red: 48/255, green: 48/255, blue: 48/255, alpha: 1)
        static var purple = UIColor(red: 58/255, green: 39/255, blue: 43/255, alpha: 1)
        static var purple_2 = UIColor(red: 74/255, green: 45/255, blue: 50/255, alpha: 1)
        static var light_purple = UIColor(red: 88/255, green: 66/255, blue: 78/255, alpha: 1)
        static var dark_purple = UIColor(red: 39/255, green: 30/255, blue: 35/255, alpha: 1)
        static var dark_purple_2 = UIColor(red: 41/255, green: 30/255, blue: 36/255, alpha: 1)
        static var dark_purple_3 = UIColor(red: 51/255, green: 38/255, blue: 45/255, alpha: 1)
        static var grey = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1)
        static var plum = UIColor(red: 134/255, green: 51/255, blue: 66/255, alpha: 1)
        static var link_blue = UIColor(red: 50/255, green: 132/255, blue: 255/255, alpha: 1)
        //  Add more colors as needed...
    }
    func fromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }

}
