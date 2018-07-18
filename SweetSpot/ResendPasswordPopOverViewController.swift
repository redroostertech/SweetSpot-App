//
//  ResendPasswordPopOverViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 6/30/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

class ResendPasswordPopOverViewController: UIViewController {

    @IBOutlet var popUpContainer: UIView!
    @IBOutlet var btn_Login: UIButton!
    @IBOutlet var popoverText: UILabel!
    
    var text: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.AppColors.purple.withAlphaComponent(0.7)
        
        popUpContainer.backgroundColor = UIColor.AppColors.plum
        popoverText.textColor = UIColor.AppColors.beige
        
        btn_Login.layer.cornerRadius = CGFloat(btn_radius)
        btn_Login.layer.borderColor = UIColor.AppColors.black.cgColor
        btn_Login.layer.borderWidth = CGFloat(btn_border_width)
        btn_Login.backgroundColor = UIColor.AppColors.beige
        btn_Login.setTitleColor(UIColor.AppColors.black,
                               for: .normal)
        if let text = self.text {
            popoverText.text = text
            btn_Login.setTitle(help_button_text.uppercased(),
                               for: .normal)
        } else {
            popoverText.text = popover_password_resent
            btn_Login.setTitle(login_log_in.uppercased(),
                               for: .normal)
        }
    }

    @IBAction func login(_ sender: UIButton) {
        self.dismiss(animated: true,
                     completion: nil)
    }
}
