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
    
    @IBOutlet weak var btnCancel: UIButton!
    
     var delegate: vwEmptyWineDelegate?
    
    
    @IBAction func btnGetStarted_Click(_ sender: Any) {
        
       delegate?.btnGetStarted_Click()
    }
    
    @IBAction func btnCancel_Click(_ sender: Any) {
        delegate?.btnCancel_Click()
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
        
        
        btnCancel.layer.cornerRadius = CGFloat(btn_radius)
        btnCancel.layer.borderColor = UIColor.AppColors.beige.cgColor
        btnCancel.layer.borderWidth = CGFloat(btn_border_width)
        btnCancel.backgroundColor = UIColor.clear
        btnCancel.setTitleColor(UIColor.AppColors.beige,
                                     for: .normal)
        
    }
    
}

protocol vwEmptyWineDelegate {
    // Classes that adopt this protocol MUST define
    // this method -- and hopefully do something in
    // that definition.
    func btnGetStarted_Click()
    func btnCancel_Click()
}


