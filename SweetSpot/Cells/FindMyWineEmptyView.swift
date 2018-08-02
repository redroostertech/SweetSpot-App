//
//  FindMyWineEmptyView.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/30/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

class FindMyWineEmptyView: UIView {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblYourWineProfile: UILabel!
    
    @IBOutlet weak var lblWineProfileType: UILabel!
    
    @IBOutlet var btnGetStarted: UIButton!
    
    @IBOutlet weak var imgProfileType: UIImageView!
    
    @IBOutlet weak var lblPrimaryText: UILabel!
    
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.AppColors.purple
        
        lblTitle.textColor = .white
        lblPrimaryText.textColor = UIColor.AppColors.beige
        lblYourWineProfile.textColor = UIColor.AppColors.beige
        lblWineProfileType.textColor = .white
        btnGetStarted.backgroundColor = UIColor.AppColors.beige
        btnGetStarted.setTitleColor(UIColor.AppColors.black,
                                    for: .normal)
        btnGetStarted.layer.cornerRadius = CGFloat(btn_radius)
    }
    
    override func layoutSubviews() {
        
    }
    
    @IBAction func btnGetStarted_Click(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    
    
}
