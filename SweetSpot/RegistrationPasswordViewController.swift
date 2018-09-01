//
//  RegistrationPasswordViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 6/30/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import Alamofire

class RegistrationPasswordViewController: UIViewController {
    
    @IBOutlet var lbl_TitleOfView: UILabel!
    @IBOutlet var text_Password: UITextField!
    @IBOutlet var lbl_Password: UILabel!
    @IBOutlet var lbl_CallToAction: UILabel!
    @IBOutlet var btn_Next: UIButton!
    @IBOutlet var btn_Cancel: UIButton!
    @IBOutlet var lbl_DidNotRecievePassword: UILabel!
    @IBOutlet var btn_EditEmail: UIButton!
    @IBOutlet var btn_ReSend: UIButton!
    @IBOutlet var viewContainer: UIView!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        text_Password.delegate = self
        
        self.view.backgroundColor = UIColor.AppColors.purple
        self.viewContainer.backgroundColor = UIColor.AppColors.dark_purple
        
        lbl_TitleOfView.textColor = UIColor.AppColors.beige
        lbl_TitleOfView.text = String(format: "Welcome, %@", user.firstName).uppercased()
        
        lbl_CallToAction.textColor = UIColor.AppColors.beige
        lbl_CallToAction.text = registration_password
        
        lbl_Password.textColor = UIColor.AppColors.beige
        
        btn_Cancel.layer.cornerRadius = CGFloat(btn_radius)
        btn_Cancel.layer.borderColor = UIColor.AppColors.beige.cgColor
        btn_Cancel.layer.borderWidth = CGFloat(btn_border_width)
        btn_Cancel.backgroundColor = UIColor.clear
        btn_Cancel.setTitleColor(UIColor.AppColors.beige,
                                 for: .normal)
        btn_Cancel.setTitle(registration_cancel.uppercased(),
                            for: .normal)
        
        btn_Next.layer.cornerRadius = CGFloat(btn_radius)
        btn_Next.layer.borderColor = UIColor.AppColors.black.cgColor
        btn_Next.layer.borderWidth = CGFloat(btn_border_width)
        btn_Next.backgroundColor = UIColor.AppColors.beige
        btn_Next.setTitleColor(UIColor.AppColors.black,
                               for: .normal)
        btn_Next.setTitle(registration_submit.uppercased(),
                          for: .normal)
        
//        btn_EditEmail.layer.cornerRadius = CGFloat(btn_radius)
//        btn_EditEmail.layer.borderColor = UIColor.AppColors.beige.cgColor
//        btn_EditEmail.layer.borderWidth = CGFloat(btn_border_width)
//        btn_EditEmail.backgroundColor = UIColor.clear
//        btn_EditEmail.setTitleColor(UIColor.AppColors.beige,
//                                    for: .normal)
//        btn_EditEmail.setTitle(registration_edit_email.uppercased(),
//                               for: .normal)
        
        btn_ReSend.layer.cornerRadius = CGFloat(btn_radius)
        btn_ReSend.layer.borderColor = UIColor.AppColors.beige.cgColor
        btn_ReSend.layer.borderWidth = CGFloat(btn_border_width)
        btn_ReSend.backgroundColor = UIColor.clear
        btn_ReSend.setTitleColor(UIColor.AppColors.beige,
                                 for: .normal)
        btn_ReSend.setTitle(registration_resend.uppercased(),
                            for: .normal)
        
        lbl_DidNotRecievePassword.textColor = UIColor.AppColors.beige
        lbl_DidNotRecievePassword.text = registration_did_not_receive_password
        
        text_Password.isSecureTextEntry = true
    }
    
    @IBAction func submit(_ sender: UIButton) {
        
        if text_Password.text == user.password{
            let sb = UIStoryboard(name: "Main",
                                  bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "QuestionaireViewController") as? QuestionaireViewController else {
                return
            }
            vc.startingViewController = self
            vc.user = self.user
            self.present(vc,
                         animated: true,
                         completion: nil)
        }else{
            showError()
        }
    }
    
    func showError(){
        let alertView = UIAlertController(title: "Wrong Password", message: "Password mismatch. Please check your email and try again.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {action in })
        alertView.addAction(okAction)
        self.show(alertView, sender: self)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    @IBAction func editEmail(_ sender: UIButton) {
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    @IBAction func resendPassword(_ sender: UIButton) {
        let parameters: Parameters = ["action": "resendPassword",
                                      "customer_id":Utils().getPermanentString(keyName: "CUSTOMER_ID")
                                      
            
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in

            
            let sb = UIStoryboard(name: "Main",
                                  bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "ResendPasswordPopOverViewController") as? ResendPasswordPopOverViewController else {
                return
            }
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc,
                         animated: true,
                         completion: nil)
        }
        //ResendPasswordPopOverViewController
        
    }
    
}

extension RegistrationPasswordViewController: UITextFieldDelegate {
    
}
