//
//  LoginViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 6/29/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var lbl_TitleOfView: UILabel!
    @IBOutlet var text_Email: UITextField!
    @IBOutlet var text_Password: UITextField!
    @IBOutlet var lbl_Email: UILabel!
    @IBOutlet var lbl_Password: UILabel!
    @IBOutlet var btn_ForgotPassword: UIButton!
    @IBOutlet var btn_GetStarted: UIButton!
    @IBOutlet var btn_Cancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text_Email.delegate = self
        text_Email.textColor = UIColor.AppColors.beige
        text_Password.delegate = self
        text_Password.textColor = UIColor.AppColors.beige
        
        setVCBackgroundImageToView(image: login_background_image)
        lbl_TitleOfView.textColor = UIColor.AppColors.beige
        lbl_Email.textColor = UIColor.AppColors.beige
        lbl_Password.textColor = UIColor.AppColors.beige
        
        btn_GetStarted.layer.cornerRadius = CGFloat(btn_radius)
        btn_GetStarted.layer.borderColor = UIColor.AppColors.black.cgColor
        btn_GetStarted.layer.borderWidth = CGFloat(btn_border_width)
        btn_GetStarted.backgroundColor = UIColor.AppColors.beige
        btn_GetStarted.setTitleColor(UIColor.AppColors.black,
                                     for: .normal)
        btn_GetStarted.setTitle(login_get_started.uppercased(),
                                for: .normal)
        btn_ForgotPassword.setTitleColor(UIColor.AppColors.beige,
                                         for: .normal)
        btn_ForgotPassword.setTitle(login_forgot_password.uppercased(),
                                    for: .normal)
        
        btn_Cancel.layer.cornerRadius = CGFloat(btn_radius)
        btn_Cancel.layer.borderColor = UIColor.AppColors.beige.cgColor
        btn_Cancel.layer.borderWidth = CGFloat(btn_border_width)
        btn_Cancel.backgroundColor = UIColor.clear
        btn_Cancel.setTitleColor(UIColor.AppColors.beige,
                                 for: .normal)
        btn_Cancel.setTitle(registration_cancel.uppercased(),
                            for: .normal)
        
        text_Password.text = "abc123"
        text_Password.isSecureTextEntry = true
        text_Email.text = "test@sweetspot.digital"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        let backgroundRadius = self.background.frame.width / 2
        //        if #available(iOS 11, *) {
        //            self.background.layer.cornerRadius = backgroundRadius
        //            self.background.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        //            self.background.clipsToBounds = true
        //        } else {
        //            self.background.backgroundColor = .red
        //            let bgImage = UIImage(named: "loginbg")
        //            let bgImageView = UIImageView(frame: self.background.frame)
        //            bgImageView.image = bgImage
        //            bgImageView.contentMode = .scaleToFill
        //            self.background.addSubview(bgImageView)
        //        }
        //        self.background.clipsToBounds = true
    }
    
    @IBAction func forgotPassword(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main",
                              bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController else {
            return print("Error performing seguing")
        }
        //  UIApplication.shared.keyWindow?.rootViewController = vc
        self.present(vc,
                     animated: true,
                     completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true,
                completion: nil)
    }
    
    @IBAction func login(_ sender: UIButton) {
        performLogin(email_address: text_Email.text!, password: text_Password.text!)
    }
    
    func performLogin(email_address:String, password:String){
        let parameters: Parameters = ["action": "authenticateUser",
                                      "email_address": email_address,
                                      
                                      "password":password
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            //print("\(response.result.value!)")
            if response.result.value == nil{
                print("found nil while getting response from server")
                return
            }
            let jsonValues = response.result.value as! [String:Any]
            
            let status = jsonValues["status"] as? Int
            
            if status != 1 {
                 self.showBadLogin()
                return
            }
            
            let data = jsonValues["data"] as! [String:Any]
            if let theJSONData = try? JSONSerialization.data(
                withJSONObject: data,
                options: []) {
                let theJSONText = String(data: theJSONData,
                                         encoding: .ascii)
                print("JSON string = \(theJSONText!)")
                
                if let customer = Customer(JSONString: theJSONText!){
                    if customer.getCustomerid() > 0{
                        
                        Utils().savePermanentString(keyName: "CUSTOMER_ID", keyValue: "\(customer.getCustomerid())")
                        Utils().savePermanentString(keyName: "IS_ONBOARDED", keyValue: "1")
                        Utils().savePermanentString(keyName: "USER_NAME", keyValue: customer.getFirstname())
                        let sb = UIStoryboard(name: "Main",
                                              bundle: nil)
                        guard let vc = sb.instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController else {
                            return self.showBadLogin()
                        }
                        //  UIApplication.shared.keyWindow?.rootViewController = vc
                        self.present(vc,
                                     animated: true,
                                     completion: nil)
                        
                        
                    }else{
                        self.showBadLogin()
                    }
                }
            }
        }
    }//performLogin
    func showBadLogin(){
        let alertView = UIAlertController(title: "Invalid Credentials", message: "You entered the wrong credentials", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {action in })
        alertView.addAction(okAction)
        self.show(alertView, sender: self)
    }
    
    
}


