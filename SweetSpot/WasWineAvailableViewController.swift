//
//  WasWineAvailableViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/4/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import Alamofire

class WasWineAvailableViewController: UIViewController {

    @IBOutlet var view_PrimaryContainer: UIView!
    @IBOutlet var btn_Share: UIButton!
    @IBOutlet var btn_Yes: UIButton!
    @IBOutlet var btn_No: UIButton!
    @IBOutlet var btn_Cancel: UIButton!
    @IBOutlet var lbl_WineName: UILabel!
    @IBOutlet var lbl_BusinessName: UILabel!
    @IBOutlet var lbl_BusinessAddress: UILabel!
    
    var user: User!
    var primaryNavigationViewController: PrimaryNavigationViewController!
    var wine:Wine = Wine(JSONString:"{}")!
    var retailer:Retailer = Retailer(JSONString:"{}")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.AppColors.purple.withAlphaComponent(0.98)
        
        view_PrimaryContainer.layer.cornerRadius = 100
        view_PrimaryContainer.clipsToBounds = true
        view_PrimaryContainer.layer.borderColor = UIColor.AppColors.black.cgColor
        view_PrimaryContainer.layer.borderWidth = 2
        view_PrimaryContainer.backgroundColor = UIColor.AppColors.plum

        btn_Cancel.layer.cornerRadius = btn_Cancel.frame.height / 2
        btn_Cancel.layer.borderColor = UIColor.AppColors.beige.cgColor
        btn_Cancel.layer.borderWidth = CGFloat(btn_border_width)
        btn_Cancel.backgroundColor = UIColor.clear
        btn_Cancel.setTitleColor(UIColor.AppColors.beige,
                                 for: .normal)
        btn_Cancel.setTitle(registration_cancel.uppercased(),
                            for: .normal)
        
        btn_No.layer.cornerRadius = btn_No.frame.height / 2
        btn_No.layer.borderColor = UIColor.AppColors.beige.cgColor
        btn_No.layer.borderWidth = CGFloat(btn_border_width)
        btn_No.backgroundColor = UIColor.clear
        btn_No.setTitleColor(UIColor.AppColors.beige,
                                 for: .normal)
        btn_No.setTitle("No".uppercased(),
                        for: .normal)
        
        btn_Yes.layer.cornerRadius = btn_Yes.frame.height / 2
        btn_Yes.layer.borderColor = UIColor.AppColors.black.cgColor
        btn_Yes.layer.borderWidth = CGFloat(btn_border_width)
        btn_Yes.backgroundColor = UIColor.AppColors.beige
        btn_Yes.setTitleColor(UIColor.AppColors.black,
                                      for: .normal)
        btn_Yes.setTitle("Yes".uppercased(),
                         for: .normal)
        
        lbl_WineName.text = wine.getWinename()
        lbl_BusinessName.text = retailer.getRetailername()
        lbl_BusinessName.text = retailer.getAddressline1() + " " + retailer.getCity() + ", " + retailer.getState()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func no(_ sender: UIButton) {
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    @IBAction func yes(_ sender: Any) {
        let parameters: Parameters = ["action": "addCustomerSelectWine",
                                      "wine_id": "\(wine.getWineaiid())",
            "customer_id":Utils().getPermanentString(keyName: "CUSTOMER_ID")
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            
            self.dismiss(animated: true,
                         completion: nil)
        }
    }
    
}
