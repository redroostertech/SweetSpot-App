//
//  MenuViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/1/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import SideMenu

class MenuViewController: UIViewController {

    @IBOutlet var lbl_TitleOfView: UILabel!
    @IBOutlet var btn_Help: UIButton!
    @IBOutlet var btn_Profile: UIButton!
    @IBOutlet var btn_FindMyWine: UIButton!
    @IBOutlet var btn_RateMyWine: UIButton!
    @IBOutlet var btn_MySweetSpot: UIButton!
    @IBOutlet var btn_MyWineJourney: UIButton!
    @IBOutlet var btn_Logout: UIButton!
    
    @IBOutlet weak var lbl_Version: UILabel!
    //var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.AppColors.purple
        SideMenuManager.default.menuFadeStatusBar = false
        lbl_Version.text = Bundle.main.releaseVersionNumberPretty
        lbl_Version.textColor = UIColor.AppColors.beige
        
        lbl_TitleOfView.textColor = UIColor.AppColors.beige
        lbl_TitleOfView.text = String(format: "Welcome, %@", "Mike"/*user.firstName*/).uppercased()
        

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func goTo(_ sender: UIButton) {
        print("Sender: ", sender)
        switch sender {
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
        default:
             break
        }
    }
    
}
