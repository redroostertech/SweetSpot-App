//
//  FindMyWineEmptyView.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/30/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

class FindMyWineEmptyView: UIViewController {
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblPrimaryText: UILabel!
    @IBOutlet var lblYourWineProfile: UILabel!
    @IBOutlet var lblWineProfileType: UILabel!
    @IBOutlet var imgviewProfileType: UIImageView!
    @IBOutlet var btnGetStarted: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.AppColors.purple
        
        lblTitle.textColor = .white
        lblPrimaryText.textColor = UIColor.AppColors.beige
        lblYourWineProfile.textColor = UIColor.AppColors.beige
        lblWineProfileType.textColor = .white
        btnGetStarted.backgroundColor = UIColor.AppColors.beige
        btnGetStarted.setTitleColor(UIColor.AppColors.black,
                                    for: .normal)
        btnGetStarted.layer.cornerRadius = CGFloat(btn_radius)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
