//
//  MySweetSpotRemoveWineViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/5/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import Alamofire

class MySweetSpotRemoveWineViewController: UIViewController {
    
    @IBOutlet var popUpContainer: UIView!
    @IBOutlet var btn_Login: UIButton!
    @IBOutlet var popoverText: UILabel!
    @IBOutlet var btn_Cancel: UIButton!
    var wine:Wine = Wine(JSONString:"{}")!
    override func viewDidLoad() {
        super.viewDidLoad()
        SSAnalytics.reportUserAction(action_type: SSAnalytics.AnalyticsActionType.DELETE_FAVORITE)
        self.view.backgroundColor = UIColor.AppColors.purple.withAlphaComponent(0.7)
        
        popUpContainer.backgroundColor = UIColor.AppColors.plum
        popoverText.textColor = UIColor.AppColors.beige
        
        btn_Login.layer.cornerRadius = CGFloat(btn_radius)
        btn_Login.layer.borderColor = UIColor.AppColors.black.cgColor
        btn_Login.layer.borderWidth = CGFloat(btn_border_width)
        btn_Login.backgroundColor = UIColor.AppColors.beige
        btn_Login.setTitleColor(UIColor.AppColors.black,
                                for: .normal)
        popoverText.text = "Are you sure you would like to remove this wine from your SweetSpot?"
        btn_Login.setTitle("Remove Wine".uppercased(),
                           for: .normal)
        
        btn_Cancel.layer.cornerRadius = CGFloat(btn_radius)
        btn_Cancel.layer.borderColor = UIColor.AppColors.beige.cgColor
        btn_Cancel.layer.borderWidth = CGFloat(btn_border_width)
        btn_Cancel.backgroundColor = UIColor.clear
        btn_Cancel.setTitleColor(UIColor.AppColors.beige,
                                 for: .normal)
        btn_Cancel.setTitle(registration_cancel.uppercased(),
                            for: .normal)
    }
    
    @IBAction func login(_ sender: UIButton) {
        let parameters: Parameters = ["action": "deleteCustomerWineFavorite",
                                      "wine_id":"\(wine.getWineaiid())",
                                      "customer_id":Utils().getPermanentString(keyName: "CUSTOMER_ID")
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            self.dismiss(animated: true,
                         completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        SSAnalytics.reportUserAction(action_type: SSAnalytics.AnalyticsActionType.DELETE_FAVORITE_CANCEL)
        self.dismiss(animated: true,
                     completion: nil)
    }
}
