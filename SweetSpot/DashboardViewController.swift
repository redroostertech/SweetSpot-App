//
//  DashboardViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/1/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire

class DashboardViewController: UIViewController {
    
    @IBOutlet var navigationViewContainer: UIView!
    @IBOutlet var view_PrimaryContainer: UIView!
    @IBOutlet var view_ButtonContainers: UIView!
    @IBOutlet var view_FMW: UIView!
    @IBOutlet var view_MWJ: UIView!
    @IBOutlet var view_MSS: UIView!
    @IBOutlet var view_RMW: UIView!
    
    @IBOutlet weak var btnUnRatedWineCount: UIButton!
    var user: User!
    var primaryNavigationViewController: PrimaryNavigationViewController!
    
    var unRatedWineCount:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        primaryNavigationViewController = PrimaryNavigationViewController()
        primaryNavigationViewController.delegate = self
        addChildViewController(primaryNavigationViewController)
        navigationViewContainer.addSubview(primaryNavigationViewController.view)
        didMove(toParentViewController: primaryNavigationViewController)
        
        setVCBackgroundImageToView(image: dashboard_background_image)
        
        
        view_PrimaryContainer.layer.cornerRadius = 80
        view_PrimaryContainer.clipsToBounds = true
        view_PrimaryContainer.layer.borderColor = UIColor.AppColors.black.cgColor
        view_PrimaryContainer.layer.borderWidth = 2
        view_PrimaryContainer.backgroundColor = UIColor.AppColors.plum
        
        view_ButtonContainers.backgroundColor = UIColor.AppColors.purple
        
        view_FMW.layer.borderColor = UIColor.AppColors.black.cgColor
        view_FMW.layer.borderWidth = 0.5
        view_MWJ.layer.borderColor = UIColor.AppColors.black.cgColor
        view_MWJ.layer.borderWidth = 0.5
        view_MSS.layer.borderColor = UIColor.AppColors.black.cgColor
        view_MSS.layer.borderWidth = 0.5
        view_RMW.layer.borderColor = UIColor.AppColors.black.cgColor
        view_RMW.layer.borderWidth = 0.5
        btnUnRatedWineCount.isHidden = true
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = ""
         getCustomerRatedWine()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
                if self.unRatedWineCount > 0 {
                    self.btnUnRatedWineCount.isHidden = false
                    self.btnUnRatedWineCount.setTitle("\(self.unRatedWineCount)", for: .normal)
                }
            }
        }
    }
    
    @IBAction func findMyWine(_ sender: UIButton) {
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
    }
    
    @IBAction func rateMyWine(_ sender: UIButton) {
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
    }
    
    @IBAction func myWineJourney(_ sender: UIButton) {
        
        if let url = URL(string: AppConstants.WINE_JOURNEY_URL) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func mySweetSpot(_ sender: UIButton) {
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
    }
    
}

extension DashboardViewController: NavDelegate {
    func doShowMenu() {
        self.performSegue(withIdentifier: "showMenu",
                          sender: self)
    }
    
    func doGoToProfile() {
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
    }
    
    func doGoToHelp() {
        if !(self is ProfileContainerViewController) {
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
        }
    }
}
