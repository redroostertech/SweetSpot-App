//
//  vwEmptyWine.swift
//  SweetSpot
//
//  Created by Iziah Reid on 8/1/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import Foundation
import UIKit

class vwEmptyWine : UIView{
    
    @IBOutlet weak var lblResults: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblProfileType: UILabel!
    
    @IBOutlet weak var imgProfileType: UIImageView!
    
    @IBOutlet weak var btnGetStarted: UIButton!
    
    @IBAction func btnGetStarted_Click(_ sender: Any) {
        
        self.removeFromSuperview()
    }
    
    
    override func awakeFromNib() {
        
        self.backgroundColor = UIColor.AppColors.purple
        
        lblResults.textColor = .white
        lblDescription.textColor = UIColor.AppColors.beige
        lblDescription.textColor = UIColor.AppColors.beige
        lblProfileType.textColor = .white
        btnGetStarted.backgroundColor = UIColor.AppColors.beige
        btnGetStarted.setTitleColor(UIColor.AppColors.black,
                                    for: .normal)
        btnGetStarted.layer.cornerRadius = CGFloat(btn_radius)
        
    }
    
}


