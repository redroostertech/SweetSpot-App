//
//  ViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 6/29/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var btn_GetStarted: UIButton!
    @IBOutlet var btn_Login: UIButton!
    @IBOutlet var lbl_CallToAction: UILabel!
    @IBOutlet var img_SubHeader: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setVCBackgroundImageToView(image: login_background_image)
        
        let vcSubHeader = UIImage(named: login_sub_header_image)
        img_SubHeader.image = vcSubHeader
        
        lbl_CallToAction.text = login_cta_text
        lbl_CallToAction.textColor = UIColor.AppColors.grey
        
        btn_GetStarted.layer.cornerRadius = CGFloat(btn_radius)
        btn_GetStarted.layer.borderColor = UIColor.AppColors.black.cgColor
        btn_GetStarted.layer.borderWidth = CGFloat(btn_border_width)
        btn_GetStarted.backgroundColor = UIColor.AppColors.beige
        btn_GetStarted.setTitleColor(UIColor.AppColors.black,
                                     for: .normal)
        btn_GetStarted.setTitle(login_get_started.uppercased(),
                                for: .normal)
        btn_Login.setTitleColor(UIColor.AppColors.black,
                                     for: .normal)
        btn_Login.setTitle(login_log_in.uppercased(),
                           for: .normal)
    }

    @IBAction func getStarted(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main",
                              bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "TermsAndConditionsViewController") as? TermsAndConditionsViewController else {
            return print("Error performing seguing")
        }
        self.present(vc,
                     animated: true,
                     completion: nil)
    }
    
    @IBAction func goToLogin(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main",
                              bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            return print("Error performing seguing")
        }
        //UIApplication.shared.keyWindow?.rootViewController = vc
        self.present(vc,
                     animated: true,
                     completion: nil)
    }
}
