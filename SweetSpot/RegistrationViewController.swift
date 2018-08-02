//
//  RegistrationViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 6/30/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import Alamofire


struct User {
    var firstName: String
    var lastName: String
    var emailAddress: String
    var zipCode: String
    var phoneNumber: String?
    var password: String
}

class RegistrationViewController: UIViewController {
    
    @IBOutlet var lbl_TitleOfView: UILabel!
    @IBOutlet var text_FIrstName: UITextField!
    @IBOutlet var text_LastName: UITextField!
    @IBOutlet var text_Email: UITextField!
    @IBOutlet var text_ConfirmEmail: UITextField!
    @IBOutlet var text_ZipCode: UITextField!
    @IBOutlet var text_PhoneNumber: UITextField!
    @IBOutlet var lbl_FIrstName: UILabel!
    @IBOutlet var lbl_LastName: UILabel!
    @IBOutlet var lbl_Email: UILabel!
    @IBOutlet var lbl_ConfirmEmail: UILabel!
    @IBOutlet var lbl_ZipCode: UILabel!
    @IBOutlet var lbl_PhoneNumber: UILabel!
    @IBOutlet var btn_Next: UIButton!
    @IBOutlet var btn_Cancel: UIButton!
    
    var didApproveGDPR: Bool!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text_FIrstName.delegate = self
        text_LastName.delegate = self
        text_Email.delegate = self
        text_ConfirmEmail.delegate = self
        text_ZipCode.delegate = self
        text_PhoneNumber.delegate = self
        
        self.view.backgroundColor = UIColor.AppColors.purple

        lbl_TitleOfView.textColor = UIColor.AppColors.beige
        lbl_FIrstName.textColor = UIColor.AppColors.beige
        lbl_LastName.textColor = UIColor.AppColors.beige
        lbl_Email.textColor = UIColor.AppColors.beige
        lbl_ConfirmEmail.textColor = UIColor.AppColors.beige
        lbl_ZipCode.textColor = UIColor.AppColors.beige
        lbl_PhoneNumber.textColor = UIColor.AppColors.beige
    
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
        btn_Next.setTitle(registration_next.uppercased(),
                          for: .normal)
        
        Utils().savePermanentString(keyName: "USER_NAME", keyValue: "")
        Utils().savePermanentString(keyName: "CUSTOMER_ID", keyValue: "")
        Utils().savePermanentString(keyName: "IS_ONBOARDED", keyValue: "")
        
        
        if AppConstants.DEBUG{
            text_FIrstName.text = "John"
            text_LastName.text = "Smith"
            text_Email.text = "john@gmail.com"
            text_ConfirmEmail.text = "john@gmail.com"
            text_PhoneNumber.text = "4045551234"
            text_ZipCode.text = "30303"
            
        }else{
            text_FIrstName.text = ""
            text_LastName.text = ""
            text_Email.text = ""
            text_ConfirmEmail.text = ""
            text_PhoneNumber.text = ""
            text_ZipCode.text = ""
        }
    }
    
    @IBAction func next(_ sender: UIButton) {
        
        self.user = User(firstName: self.text_FIrstName.text ?? "",
                         lastName: self.text_LastName.text ?? "",
                         emailAddress: self.text_ConfirmEmail.text ?? "",
                         zipCode: self.text_ZipCode.text ?? "",
                         phoneNumber: self.text_PhoneNumber.text ?? "", password: "")
        
       registerUser()
    }
    
    func validateFields() -> Bool{
        var isValid = false
        
        if text_Email.text!.isEmpty || text_ZipCode.text!.isEmpty || text_LastName.text!.isEmpty || text_FIrstName.text!.isEmpty || text_ConfirmEmail.text!.isEmpty{
            let alert = UIAlertController(title: "Invalid", message: "Sorry, no fields can be empty", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return isValid
        }
        
        if !self.text_ConfirmEmail.text!.isEmail{
            //alert
            let alert = UIAlertController(title: "Invalid", message: "Email address must be in email format", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return isValid
        }
        
        
        if text_ConfirmEmail.text!.lowercased() != text_Email.text!.lowercased() {
            let alert = UIAlertController(title: "Invalid", message: "Email address and confirm email address must be equal", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return isValid
        }
        
        if self.text_ZipCode.text!.length != 5{
            //alert
            let alert = UIAlertController(title: "Invalid", message: "Zip Code must be 5 digits", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return isValid
        }
        
        if self.text_PhoneNumber.text!.length >  0 && self.text_PhoneNumber.text!.length != 10{
            //alert
            let alert = UIAlertController(title: "Invalid", message: "Phone number must be 10 digits", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return isValid
        }
        
        
        return true
    }
    
    func registerUser(){
        if !self.validateFields(){
            return
        }
        let parameters: Parameters = ["action": "registerUser",
                                      "email_address": self.user!.emailAddress,
                                      "first_name": self.user!.firstName,
                                      "last_name": self.user!.lastName,
                                      "phone_number": self.user!.phoneNumber!,
                                      "zip_code": self.user!.zipCode
                                    
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            print("\(response.result.value!)")
            
            let jsonValues = response.result.value as! [String:Any]
            
            let status = jsonValues["status"] as? Int
            let message = jsonValues["message"] as? String
            if status != 1 {
                self.showError(message: message!)
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
                        Utils().savePermanentString(keyName: "USER_NAME", keyValue: customer.getFirstname())
                        let sb = UIStoryboard(name: "Main",
                                              bundle: nil)
                        guard
                            let vc = sb.instantiateViewController(withIdentifier: "RegistrationPasswordViewController") as? RegistrationPasswordViewController,
                            var user = self.user else
                            {
                                return print("Error performing seguing")
                            }
                        user.password = customer.getPassword()
                        vc.user = user
                        self.present(vc,
                                     animated: true,
                                     completion: nil)
                        
                        
                    }else{
                        self.showError(message:"customer id less than 0")
                    }
                }
            }
        }
    }//performLogin
    func showError(message:String){
        let alertView = UIAlertController(title: "Invalid Credentials", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {action in })
        alertView.addAction(okAction)
        self.show(alertView, sender: self)
    }
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true,
                     completion: nil)
    }
}


extension RegistrationViewController: UITextFieldDelegate {
    
}
