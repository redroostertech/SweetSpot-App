//
//  ProfileContainerViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/3/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

import UIKit

class ProfileContainerViewController:
    UIViewController,
    CAPSPageMenuDelegate
{
    
    @IBOutlet var navigationViewContainer: UIView!
    var user: User!
    var pageMenu : CAPSPageMenu?
    var navigation: SecondaryNavigationViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setVCBackgroundImageToView(image: dashboard_background_image)
        
        navigation = SecondaryNavigationViewController()
        addChildViewController(navigation)
        navigationViewContainer.addSubview(navigation.view)
        didMove(toParentViewController: navigation)
        navigation.delegate = self
        navigation.titleForView = "MY PROFILE"
        
        var controllerArray : [UIViewController] = []
        
        let controller1 : ProfileViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        controller1.title = profile_personal_info.uppercased()
        controller1.containerViewController = self
        
        controllerArray.append(controller1)
        
        let controller2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WineProfileViewController") as! WineProfileViewController
        controller2.title = profile_wine_profile.uppercased()
        controller2.containerViewController = self
        controllerArray.append(controller2)
        
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(0),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0),
            .scrollMenuBackgroundColor(.clear),
            .viewBackgroundColor(.clear),
            .selectionIndicatorColor(UIColor.white),
            .selectionIndicatorHeight(3.0),
            .selectedMenuItemLabelColor(UIColor.white),
            .unselectedMenuItemLabelColor(UIColor.AppColors.beige),
            .menuHeight(72.0),
            .menuItemWidth(90.0),
            .centerMenuItems(true)
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray,
                                frame: CGRect(x: 0.0,
                                              y: (self.navigationViewContainer.frame.height) + self.navigationViewContainer.frame.origin.y,
                                              width: self.view.frame.width,
                                              height: self.view.frame.height),
                                pageMenuOptions: parameters)
        self.view.addSubview(pageMenu!.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ProfileContainerViewController: NavDelegate {
    func doDismiss() {
        dismiss(animated: true,
                completion: nil)
    }
    
    func doGoToProfile() {
        
        if !(self is ProfileContainerViewController) {
            let sb = UIStoryboard(name: "Main",
                                  bundle: nil)
            guard
                let vc = sb.instantiateViewController(withIdentifier: "ProfileContainerViewController") as? ProfileContainerViewController
                else
            {
                return
            }
            
            present(vc,
                    animated: true,
                    completion: nil)
        }
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
