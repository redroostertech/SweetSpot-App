//
//  MenuViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/1/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire

class MenuViewController: UIViewController {

    @IBOutlet var lbl_TitleOfView: UILabel!
    @IBOutlet var btn_Help: UIButton!
    @IBOutlet var btn_Profile: UIButton!
    @IBOutlet var btn_FindMyWine: UIButton!
    @IBOutlet var btn_RateMyWine: UIButton!
    @IBOutlet var btn_MySweetSpot: UIButton!
    @IBOutlet var btn_MyWineJourney: UIButton!
    @IBOutlet var btn_Logout: UIButton!
    
    @IBOutlet weak var btnUnratedWineCount: UIButton!
    @IBOutlet weak var lbl_Version: UILabel!
    
    var unRatedWineCount:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.AppColors.purple
        SideMenuManager.default.menuFadeStatusBar = false
        lbl_Version.text = Bundle.main.releaseVersionNumberPretty
        lbl_Version.textColor = UIColor.AppColors.beige
        
        lbl_TitleOfView.textColor = UIColor.AppColors.beige
        lbl_TitleOfView.text = String(format: "Welcome, %@", "User"/*user.firstName*/).uppercased()
        
        if Utils().getPermanentString(keyName: "USER_NAME") != "" {
            lbl_TitleOfView.text = Utils().getPermanentString(keyName: "USER_NAME")
        }

        btn_Help.setAttributedTitle(NSAttributedString(string: "Help",
                                                       attributes: [.foregroundColor : UIColor.AppColors.beige]), for: .normal)

        btn_Profile.setAttributedTitle(NSAttributedString(string: "Profile",
                                                          attributes: [.foregroundColor : UIColor.AppColors.beige]), for: .normal)
        btn_FindMyWine.setAttributedTitle(NSAttributedString(string: "Find My Wine",
                                                             attributes: [.foregroundColor : UIColor.AppColors.beige]), for: .normal)
        btn_RateMyWine.setAttributedTitle(NSAttributedString(string: "Rate My Wine",
                                                             attributes: [.foregroundColor : UIColor.AppColors.beige]), for: .normal)
        btn_MySweetSpot.setAttributedTitle(NSAttributedString(string: "My Sweet Spot",
                                                              attributes: [.foregroundColor : UIColor.AppColors.beige]), for: .normal)
        btn_MyWineJourney.setAttributedTitle(NSAttributedString(string: "My Wine Journey",
                                                                attributes: [.foregroundColor : UIColor.AppColors.beige]), for: .normal)
        btn_Logout.setAttributedTitle(NSAttributedString(string: "Log Out",
                                                         attributes: [.foregroundColor : UIColor.AppColors.beige]), for: .normal)
        getCustomerRatedWine()
        btnUnratedWineCount.isHidden = true
    }
    
    func getCustomerRatedWine(){
        let parameters: Parameters = ["action": "getCustomerRatedWine",
                                      "rating_type":"2",
                                      "customer_id":Utils().getPermanentString(keyName: "CUSTOMER_ID")
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            
            if response.result.value == nil{
                return
            }
            let jsonValues = response.result.value as! [String:Any]
            
            let status = jsonValues["status"] as? Int
            if status != 1{
                print("error from server: \(jsonValues["message"])")
                
                return
            }
            let data = jsonValues["data"] as! [String:Any]
            if let theJSONData = try? JSONSerialization.data( withJSONObject: data, options: []) {
                let theJSONText = String(data: theJSONData,
                                         encoding: .ascii)
                let wineList = WineList(JSONString: theJSONText!)!
                self.unRatedWineCount = wineList.wineList.count
                if self.unRatedWineCount > 0{
                    self.btnUnratedWineCount.isHidden = false
                    self.btnUnratedWineCount.setTitle("\(self.unRatedWineCount)", for: .normal)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func goTo(_ sender: UIButton) {
        print("Sender: ", sender)
        switch sender {
            
        case btn_Logout:
            Utils().savePermanentString(keyName: "USER_NAME", keyValue: "")
            Utils().savePermanentString(keyName: "CUSTOMER_ID", keyValue: "")
            Utils().savePermanentString(keyName: "IS_ONBOARDED", keyValue: "")
            Utils().savePermanentString(keyName: "RETAIL_LIST", keyValue: "")
            let appDelegate : AppDelegate! = UIApplication.shared.delegate as! AppDelegate
            appDelegate.logoutUser()
            
            break
        case btn_Help:
            let sb = UIStoryboard(name: "Main",
                                  bundle: nil)
            guard
                let vc = sb.instantiateViewController(withIdentifier: "HelpViewController") as? HelpViewController
                else
            {
                return
            }
            //vc.user = self.user
            present(vc,
                    animated: true,
                    completion: nil)
            break
            
            
        case btn_RateMyWine:
            let sb = UIStoryboard(name: "Main",
                                  bundle: nil)
            guard
                let vc = sb.instantiateViewController(withIdentifier: "RateMyWineContainerController") as? RateMyWineContainerController
                else
            {
                return
            }
            //vc.user = self.user
            present(vc,
                    animated: true,
                    completion: nil)
            break
        case btn_Profile:
            let sb = UIStoryboard(name: "Main",
                                  bundle: nil)
            guard
                let vc = sb.instantiateViewController(withIdentifier: "ProfileContainerViewController") as? ProfileContainerViewController
                else
            {
                return
            }
            //vc.user = self.user
            present(vc,
                    animated: true,
                    completion: nil)
        case btn_MySweetSpot:
            let sb = UIStoryboard(name: "Main",
                                  bundle: nil)
            guard
                let vc = sb.instantiateViewController(withIdentifier: "MySweetSpotViewController") as? MySweetSpotViewController
                else
            {
                return
            }
            //vc.user = self.user
            present(vc,
                    animated: true,
                    completion: nil)
        case btn_FindMyWine:
            let sb = UIStoryboard(name: "Main",
                                  bundle: nil)
            guard
                let vc = sb.instantiateViewController(withIdentifier: "FindMyWineViewController") as? FindMyWineViewController
                else
            {
                return
            }
            //vc.user = self.user
            present(vc,
                    animated: true,
                    completion: nil)
            break
        case btn_MyWineJourney:
            if let url = URL(string: AppConstants.WINE_JOURNEY_URL) {
                UIApplication.shared.open(url, options: [:])
            }
            break
        default:
             break
        }
    }
    
}
