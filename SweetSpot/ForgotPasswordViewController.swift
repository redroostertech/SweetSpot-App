//
//  ForgotPasswordViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 6/29/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import Alamofire

class ForgotPasswordViewController: UIViewController {

    @IBOutlet var lbl_TitleOfView: UILabel!
    @IBOutlet var text_Email: UITextField!
    @IBOutlet var lbl_Email: UILabel!
    @IBOutlet var lbl_Line: UILabel!
    @IBOutlet var btn_SendPassword: UIButton!
    @IBOutlet var btn_Cancel: UIButton!
    @IBOutlet var lbl_CallToAction: UILabel!
    
    var didSendPassword = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let backgroundRadius = background.frame.width / 2
//        if #available(iOS 11, *) {
//            background.layer.cornerRadius = backgroundRadius
//            background.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//        } else {
//            let rectShape = CAShapeLayer()
//            rectShape.bounds = background.frame
//            rectShape.position = background.center
//            rectShape.path = UIBezierPath(roundedRect: background.bounds,
//                                          byRoundingCorners: [.bottomLeft , .bottomRight , .topLeft],
//                                          cornerRadii: CGSize(width: backgroundRadius, height: backgroundRadius)).cgPath
//            background.layer.mask = rectShape
//        }
//        background.clipsToBounds = true
        
        text_Email.delegate = self
        text_Email.textColor = UIColor.AppColors.beige
        
        setVCBackgroundImageToView(image: login_background_image)
        
        lbl_TitleOfView.textColor = UIColor.AppColors.beige
        lbl_CallToAction.textColor = UIColor.AppColors.beige
        lbl_CallToAction.text = forgot_password_will_send
        lbl_Email.textColor = UIColor.AppColors.beige
        
        btn_SendPassword.layer.cornerRadius = CGFloat(btn_radius)
        btn_SendPassword.layer.borderColor = UIColor.AppColors.black.cgColor
        btn_SendPassword.layer.borderWidth = CGFloat(btn_border_width)
        btn_SendPassword.backgroundColor = UIColor.AppColors.beige
        btn_SendPassword.setTitleColor(UIColor.AppColors.black,
                                       for: .normal)
        btn_SendPassword.setTitle(forgot_password_send_password.uppercased(),
                                  for: .normal)
    }
    
    @IBAction func forgotPassword(_ sender: UIButton) {
        if didSendPassword == false {
            forgotPassword()
            
        } else {
            self.dismiss(animated: true,
                         completion: nil)
        }
    }
    
    
    func forgotPassword(){
        let parameters: Parameters = ["action": "forgotPassword",
                                      "email_address": text_Email.text!
            
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            //print("\(response.result.value!)")
            
            let jsonValues = response.result.value as! [String:Any]
            
            let status = jsonValues["status"] as? Int
            
            if status != 1 {
                self.showError()
                return
            }
            
           
            self.didSendPassword = true
            self.lbl_CallToAction.text = forgot_password_did_send
            self.text_Email.isHidden = true
            self.lbl_Email.isHidden = true
            self.lbl_Line.isHidden = true
            self.btn_SendPassword.setTitle(forgot_password_login.uppercased(),
                                      for: .normal)
        }
    }//performLogin
    func showError(){
        let alertView = UIAlertController(title: "Invalid Credentials", message: "We couldn't find your password.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {action in })
        alertView.addAction(okAction)
        self.show(alertView, sender: self)
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true,
                     completion: nil)
    }
    
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    
}
