//
//  TermsAndConditionsViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 6/30/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

class TermsAndConditionsViewController: UIViewController {

    @IBOutlet var lbl_TitleOfView: UILabel!
    @IBOutlet var btn_GetStarted: UIButton!
    @IBOutlet var btn_Cancel: UIButton!
    @IBOutlet var btn_GDPR: UIButton!
    @IBOutlet var lbl_GDPR: UILabel!
    @IBOutlet var view_GDPR_Container: UIView!
    
    @IBOutlet var GDPR: UITextView!
    
    var didAcceptGDPR = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.AppColors.purple
        lbl_TitleOfView.text = tofc_title
        lbl_TitleOfView.textColor = UIColor.AppColors.beige
        
        lbl_GDPR.textColor = UIColor.AppColors.beige
        lbl_GDPR.text = tofc_gdpr_text.uppercased()
        
        GDPR.textColor = UIColor.AppColors.beige
        GDPR.backgroundColor = UIColor.clear
        
        btn_GDPR.layer.cornerRadius = CGFloat(tofc_gdpr_btn_radius)
        btn_GDPR.backgroundColor = UIColor.AppColors.beige
        
        btn_GetStarted.layer.cornerRadius = CGFloat(btn_radius)
        btn_GetStarted.layer.borderColor = UIColor.AppColors.black.cgColor
        btn_GetStarted.layer.borderWidth = CGFloat(btn_border_width)
        btn_GetStarted.backgroundColor = UIColor.AppColors.beige
        btn_GetStarted.setTitleColor(UIColor.AppColors.black,
                                     for: .normal)
        btn_GetStarted.setTitle(tofc_get_started.uppercased(),
                                for: .normal)
        
        btn_Cancel.layer.cornerRadius = CGFloat(btn_radius)
        btn_Cancel.layer.borderColor = UIColor.AppColors.beige.cgColor
        btn_Cancel.layer.borderWidth = CGFloat(btn_border_width)
        btn_Cancel.backgroundColor = UIColor.clear
        btn_Cancel.setTitleColor(UIColor.AppColors.beige,
                                     for: .normal)
        btn_Cancel.setTitle(tofc_cancel.uppercased(),
                                for: .normal)
        
        view_GDPR_Container.backgroundColor = UIColor.AppColors.dark_purple
    }
    
    @IBAction func getStarted(_ sender: UIButton) {
        if didAcceptGDPR == false {
            let alertView = UIAlertController(title: "", message: "Please accept our terms and conditions.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {action in })
            alertView.addAction(okAction)
            self.show(alertView, sender: self)
        } else {
            let sb = UIStoryboard(name: "Main",
                                  bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "RegistrationViewController") as? RegistrationViewController else {
                return print("Error performing seguing")
            }
            vc.didApproveGDPR = self.didAcceptGDPR
            self.present(vc,
                         animated: true,
                         completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    @IBAction func gdpr(_ sender: UIButton) {
        if didAcceptGDPR == false {
            didAcceptGDPR = true
            let selectedState = UIImage(named: "selected")
            self.btn_GDPR.setBackgroundImage(selectedState, for: .normal)
            self.btn_GDPR.backgroundColor = .clear
        } else {
            didAcceptGDPR = false
            self.btn_GDPR.setBackgroundImage(nil,
                                             for: .normal)
            
            self.btn_GDPR.backgroundColor = UIColor.AppColors.beige
        }
    }
}
