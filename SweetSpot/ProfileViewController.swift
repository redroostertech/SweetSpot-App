//
//  ProfileViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/1/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import Alamofire
class ProfileViewController: UIViewController {
    
    @IBOutlet var text_FIrstName: UITextField!
    @IBOutlet var text_LastName: UITextField!
    @IBOutlet var text_Email: UITextField!
    @IBOutlet var text_ZipCode: UITextField!
    @IBOutlet var text_PhoneNumber: UITextField!
    @IBOutlet var lbl_FIrstName: UILabel!
    @IBOutlet var lbl_LastName: UILabel!
    @IBOutlet var lbl_Email: UILabel!
    @IBOutlet var lbl_ZipCode: UILabel!
    @IBOutlet var lbl_PhoneNumber: UILabel!
    @IBOutlet var btn_SaveChanges: UIButton!
    @IBOutlet var btn_Cancel: UIButton!
    @IBOutlet var btn_FirstName: UIButton!
    @IBOutlet var btn_LastName: UIButton!
    @IBOutlet var btn_ZipCode: UIButton!
    @IBOutlet var btn_EmailAddress: UIButton!
    @IBOutlet var btn_PhoneNumber: UIButton!
    
    var user: User?
    var btn_Save: UIButton?
    var containerViewController:ProfileContainerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        text_FIrstName.delegate = self
        text_LastName.delegate = self
        text_Email.delegate = self
        text_ZipCode.delegate = self
        text_PhoneNumber.delegate = self
        
        self.view.backgroundColor = .clear
        
        lbl_FIrstName.textColor = UIColor.AppColors.beige
        lbl_LastName.textColor = UIColor.AppColors.beige
        lbl_Email.textColor = UIColor.AppColors.beige
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
        
        btn_SaveChanges.layer.cornerRadius = CGFloat(btn_radius)
        btn_SaveChanges.layer.borderColor = UIColor.AppColors.black.cgColor
        btn_SaveChanges.layer.borderWidth = CGFloat(btn_border_width)
        btn_SaveChanges.backgroundColor = UIColor.AppColors.beige
        btn_SaveChanges.setTitleColor(UIColor.AppColors.black,
                                      for: .normal)
        btn_SaveChanges.setTitle(profile_save_changes.uppercased(),
                                 for: .normal)
        loadCustomer()
    }
    
    @IBAction func saveChanges(_ sender: UIButton) {
        
        
        let parameters: Parameters = ["action": "updateUserProfile",
                                      "customer_id":Utils().getPermanentString(keyName: "CUSTOMER_ID"),
                                      "first_name":text_FIrstName.text!,
                                      "last_name":text_LastName.text!,
                                      "phone_number":text_PhoneNumber.text!,
                                      "zip_code":text_ZipCode.text!
            
            
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseString { response in
           self.goDashboard()
        }
        
        
    }
    
    
    func loadCustomer(){
        let parameters: Parameters = ["action": "getCustomerByID",
                                      "customer_id":Utils().getPermanentString(keyName: "CUSTOMER_ID")
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            
            let jsonValues = response.result.value as! [String:Any]
            
            let status = jsonValues["status"] as? Int
            if status != 1{
                return
            }
            let data = jsonValues["data"] as! [String:Any]
            if let theJSONData = try? JSONSerialization.data( withJSONObject: data, options: []) {
                let theJSONText = String(data: theJSONData,
                                         encoding: .ascii)
                print("JSON string = \(theJSONText!)")
                
                if let customer = Customer(JSONString: theJSONText!){
                    self.text_FIrstName.text = customer.getFirstname()
                    self.text_LastName.text = customer.getLastname()
                    self.text_PhoneNumber.text = customer.getPhonenumber()
                    self.text_ZipCode.text = customer.getZipcode()
                    self.text_Email.text = customer.getEmailaddress()
                }
            }
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        goDashboard()
    }
    
    func goDashboard(){
        containerViewController?.doDismiss()
    }
    
    @IBAction func editField(_ sender: UIButton) {
        switch sender {
        case self.btn_FirstName:
            print("First Name")
            self.showSaveButtonOn(sender: sender)
        case self.btn_LastName:
            print("Last Name")
            self.showSaveButtonOn(sender: sender)
        case self.btn_ZipCode:
            print("Zip Code")
            self.showSaveButtonOn(sender: sender)
        case self.btn_EmailAddress:
            print("Email Address")
            self.showSaveButtonOn(sender: sender)
        case self.btn_PhoneNumber:
            print("Phone Number")
            self.showSaveButtonOn(sender: sender)
        default:
            print("None")
        }
    }
    func showSaveButtonOn(sender: UIButton) {
        if let btn_Save = self.btn_Save {
            btn_Save.removeFromSuperview()
        }
        self.btn_Save = UIButton(frame: CGRect(x: sender.frame.origin.x - 50,
                                               y: sender.frame.origin.y + sender.frame.height + 16,
                                               width: 100,
                                               height: 30))
        
        self.btn_Save?.layer.cornerRadius = CGFloat(self.btn_Save!.frame.height / 2)
        self.btn_Save?.layer.borderColor = UIColor.AppColors.black.cgColor
        self.btn_Save?.layer.borderWidth = CGFloat(btn_border_width)
        self.btn_Save?.backgroundColor = UIColor.AppColors.beige
        self.btn_Save?.setTitleColor(UIColor.AppColors.black,
                                     for: .normal)
        self.btn_Save?.setTitle("Save".uppercased(),
                                for: .normal)
        
        self.view.addSubview(self.btn_Save!)
    }
}

extension ProfileViewController: UITextFieldDelegate {
    
}
