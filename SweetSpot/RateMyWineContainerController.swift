//
//  RateMyWineContainerController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/5/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

class RateMyWineContainerController:
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
        navigation.titleForView = "RATE MY WINE"
        
        var controllerArray : [UIViewController] = []
        
        let controller1 : UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RateMyWineAllWInesController") as! RateMyWineAllWInesController
        controller1.title = "All Wines".uppercased()
        controllerArray.append(controller1)
        
        let controller2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RateMyWineUnRatedController") as! RateMyWineUnRatedController
        controller2.title = "Unrated".uppercased()
        controllerArray.append(controller2)
        
        let controller3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RateMyWineRatedController") as! RateMyWineRatedController
        controller3.title = "Rated".uppercased()
        controllerArray.append(controller3)
    
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
       
        //self.view.addSubview(pageMenu!.view)
        
        addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        pageMenu!.didMove(toParentViewController: self)
         self.pageMenu!.controllerScrollView.isScrollEnabled = false;
        print("\(self.pageMenu?.view.frame)")
        NotificationCenter.default.addObserver(self, selector: #selector(updatePageMenu(notfication:)), name: .addReviewDismissed, object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("RateMyWineContainerController viewWillAppear")
        
    }
    
    @objc func updatePageMenu(notfication: NSNotification) {
        print("updating PageMenu")
//        DispatchQueue.main.async {
//            print("\(self.pageMenu?.view.frame)")
//
//            self.pageMenu?.view.frame = CGRect(x: 0.0,
//                                          y: (self.navigationViewContainer.frame.height) + 150 + self.navigationViewContainer.frame.origin.y,
//                                          width: self.view.frame.width,
//                                          height: self.view.frame.height)
//             print("\(self.pageMenu?.view.frame)")
//        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension RateMyWineContainerController: NavDelegate {
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
            //vc.user = self.user
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
    
    func doGoHome(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
