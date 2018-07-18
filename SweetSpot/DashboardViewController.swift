//
//  DashboardViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/1/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import SideMenu

class DashboardViewController: UIViewController {

    @IBOutlet var navigationViewContainer: UIView!
    @IBOutlet var view_PrimaryContainer: UIView!
    @IBOutlet var view_ButtonContainers: UIView!
    @IBOutlet var view_FMW: UIView!
    @IBOutlet var view_MWJ: UIView!
    @IBOutlet var view_MSS: UIView!
    @IBOutlet var view_RMW: UIView!
    
    var user: User!
    var primaryNavigationViewController: PrimaryNavigationViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        primaryNavigationViewController = PrimaryNavigationViewController()
        primaryNavigationViewController.delegate = self
        addChildViewController(primaryNavigationViewController)
        navigationViewContainer.addSubview(primaryNavigationViewController.view)
        didMove(toParentViewController: primaryNavigationViewController)
        
        setVCBackgroundImageToView(image: dashboard_background_image)

        
        view_PrimaryContainer.layer.cornerRadius = 100
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
