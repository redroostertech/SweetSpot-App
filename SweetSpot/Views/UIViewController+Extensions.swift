import Foundation
import UIKit

extension UIViewController {
    
    func setVCBackgroundImageToView(image: String) {
        let vcBackgroundImageView = UIImageView(frame: self.view.frame)
        let vcBackgroundImage = UIImage(named: image)
        vcBackgroundImageView.image = vcBackgroundImage
        vcBackgroundImageView.contentMode = .scaleAspectFill
        vcBackgroundImageView.clipsToBounds = true
        self.view.insertSubview(vcBackgroundImageView,
                                at: 0)
    }
    
    func setVCBackgroundImageToViewWithGradient(image: String) {
        let vcBackgroundImageView = UIImageView(frame: self.view.frame)
        let vcBackgroundImage = UIImage(named: image)
        vcBackgroundImageView.image = vcBackgroundImage
        vcBackgroundImageView.contentMode = .scaleAspectFill
        vcBackgroundImageView.clipsToBounds = true
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.AppColors.purple.cgColor, UIColor.clear]
        gradientLayer.locations = [0.3, 0.6]
        
        vcBackgroundImageView.layer.addSublayer(gradientLayer)
        
        self.view.insertSubview(vcBackgroundImageView,
                                at: 0)
    }
    
    public func programmaticSegue(vcName: String, storyBoard: String) -> Any? {
        let sb = UIStoryboard.init(name: storyBoard, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: vcName)
        return vc
    }
    
    public func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    public func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
    /*public func peformProgrammaticSegueNewStack(nameForStoryBoard name: String, idForViewController id: String) {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: id)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    public func peformProgrammaticSegueCurrentStack(sendingViewController viewController: UIViewController, nameForStoryBoard name: String, idForViewController id: String) {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: id)
        self.present(viewController, animated: true, completion: nil)
    }
    
    public func peformProgrammaticNavigationSegueCurrentStack(sendingViewController viewController: UIViewController, nameForStoryBoard name: String, idForViewController id: String) {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: id)
        self.navigationController?.pushViewController(viewController, animated: true)
        //self.present(viewController, animated: true, completion: nil)
    }
    
    public func sendTestAlerts(sendingViewController viewController: UIViewController, titleForAlert title: String, messageForAlert message: String, completion: (() -> Void)?) {
        let testAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
            testAlert.dismiss(animated: true, completion: nil)
            completion?()
        }
        testAlert.addAction(confirmAction)
        self.present(testAlert, animated: true, completion: nil)
    }
    
//    func storeTokensProfileDefaults(access: String, refresh: String, sportsid: String, guid: UUID, completion: @escaping () -> Void) {
//        UserDefaults.standard.set(access, forKey: UserDefaults.ProfileKeys.accessToken)
//        UserDefaults.standard.set(refresh, forKey: UserDefaults.ProfileKeys.refreshRoken)
//        UserDefaults.standard.set(sportsid, forKey: UserDefaults.ProfileKeys.sportsID)
//        UserDefaults.standard.set(guid.uuidString, forKey: UserDefaults.ProfileKeys.profileGuid)
//        completion()
//    }
    
    func deleteTokensProfileDefaults(access: String, refresh: String, sportsid: String, guid: UUID, completion: @escaping () -> Void) {
        UserDefaults.standard.set(nil, forKey: UserDefaults.ProfileKeys.accessToken)
        UserDefaults.standard.set(nil, forKey: UserDefaults.ProfileKeys.refreshRoken)
        UserDefaults.standard.set(nil, forKey: UserDefaults.ProfileKeys.sportsID)
        UserDefaults.standard.set(nil, forKey: UserDefaults.ProfileKeys.profileGuid)
        completion()
    }
    
//   public func storeLocalProperties(data: User, completion: @escaping () -> Void) {
//        UserDefaults.standard.set(data.getUserid(), forKey: UserDefaults.UserSettings.userid)
//        UserDefaults.standard.set(data.getUsername(), forKey: UserDefaults.UserSettings.username)
//        UserDefaults.standard.set(true, forKey: UserDefaults.AuthenticationKeys.sessionActive)
//        completion()
//
//    }
//
//    public func destroyLocalDefaultProperties(completion: @escaping () -> Void) {
//        UserDefaults.standard.set(nil, forKey: UserDefaults.UserSettings.userid)
//        UserDefaults.standard.set(nil, forKey: UserDefaults.UserSettings.username)
//        UserDefaults.standard.set(nil, forKey: UserDefaults.AuthenticationKeys.sessionActive)
//        completion()
//    }
    
    func hideNavigationBarHairline() {
        if let navController = self.navigationController {
            navController.hidesNavigationBarHairline = true
        }
    }
    func hideNavigationBar() {
        if
            let navController = self.navigationController,
            !(navController.navigationBar.isHidden)
        {
            navController.navigationBar.isHidden = true
        }
    }
    
    func showNavigationBar() {
        if
            let navController = self.navigationController,
            (navController.navigationBar.isHidden)
        {
            navController.navigationBar.isHidden = false
        }
    }
    
    func clearNavigationBackButtonText() {
        if (self.navigationController != nil) {
            self.navigationItem.title = ""
        }
    }
    
    func updateNavigationBar(title: String) {
        if (self.navigationController != nil) {
            self.navigationItem.title = title
        }
    }
    
    func updateNavigationBar(withBackgroundColor bgColor: UIColor, andTintColor tintColor: UIColor) {
        if (self.navigationController != nil) {
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.barTintColor = bgColor
            self.navigationController?.navigationBar.tintColor = tintColor
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: tintColor]
        }
    }
    
    func updateNavigationBar(tintColor: UIColor) {
        if (self.navigationController != nil) {
            self.navigationController?.navigationBar.tintColor = tintColor
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: tintColor]
        }
    }
    
    func updateNavigationBar(title: String, andColor color: UIColor) {
        if (self.navigationController != nil) {
            self.navigationItem.title = title
        }
    }
    
    func navigateToView(withID vid: String, fromStoryboard sid: String = "Main") {
        let storyboard = UIStoryboard(name: sid, bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: vid)
        UIApplication.shared.keyWindow?.rootViewController = viewcontroller
    }
    
    func pushToView(withID vid: String, fromStoryboard sid: String = "Main") {
        let storyboard = UIStoryboard(name: sid, bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: vid)
        if (self.navigationController != nil) {
            self.navigationController!.pushViewController(viewcontroller, animated: true)
        } else {
            self.present(viewcontroller, animated: true, completion: nil)
        }
    }
    func popViewController(to vid: String? = nil, fromStoryboard sid: String? = nil){
        guard let idForViewController = vid, let idForStoryboard = sid else {
            if (self.navigationController != nil) {
                self.navigationController!.popViewController(animated: true)
            }
            return
        }
        let storyboard = UIStoryboard(name: idForStoryboard, bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: idForViewController)
        if (self.navigationController != nil) {
            self.navigationController!.popToViewController(viewcontroller, animated: true)
        }
    }
    func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    func showHUD() {
//        SVProgressHUD.show()
//        UIApplication.shared.beginIgnoringInteractionEvents()
//        SVProgressHUD.setBackgroundColor(UIColor.orange)
//        SVProgressHUD.setForegroundColor(UIColor.white)
    }
    func hideHUD() {
//        if SVProgressHUD.isVisible() {
//            SVProgressHUD.dismiss()
//        }
//        UIApplication.shared.endIgnoringInteractionEvents()
    }
    func scrollToTop(of tableView: UITableView, completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            if tableView.visibleCells.count > 0 {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
            completion()
        }
    }
    
    func setBackground(_ imageName: String, onView view: UIView) {
        let image = UIImage(named: imageName)
        let imageView = UIImageView(frame: view.frame)
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        view.addSubview(imageView)
        view.sendSubview(toBack: imageView)
    }
    
    func setBackground(_ color: UIColor, onView view: UIView) {
        self.view.backgroundColor = color
    }
    
    func addPadding(toTextField field: UITextField, withWidth width: CGFloat) {
        let paddingLeft = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: width,
                                               height: field.frame.height))
        field.leftView = paddingLeft
        field.leftViewMode = .always
    }
    func addAsChild(_ child: UIViewController,
                    usingView view: UIView,
                    handleTableView tableview: UITableView?,
                    hanldeCollectionView collectionview: UICollectionView?)
    {
        child.view.frame = view.bounds
        
        tableview?.frame = view.bounds
        collectionview?.frame = view.bounds
        
        addChildViewController(child)
        view.addSubview(child.view)
        didMove(toParentViewController: child)
    }
}

extension UIViewController {
    func hideNavigationBarHairline() {
        if let navController = self.navigationController {
            navController.hidesNavigationBarHairline = true
        }
    }
    func hideNavigationBar() {
        if let navController = self.navigationController {
            navController.navigationBar.isHidden = true
        }
    }
    
    func showNavigationBar() {
        if let navController = self.navigationController {
            navController.navigationBar.isHidden = false
        }
    }
    
    func clearNavigationBackButtonText() {
        if (self.navigationController != nil) {
            self.navigationItem.title = ""
        }
    }
    
    func updateNavigationBar(title: String) {
        if (self.navigationController != nil) {
            self.navigationItem.title = title
        }
    }
    
    func updateNavigationBar(withBackgroundColor bgColor: UIColor, andTintColor tintColor: UIColor) {
        if (self.navigationController != nil) {
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.barTintColor = bgColor
            self.navigationController?.navigationBar.tintColor = tintColor
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: tintColor]
        }
    }
    
    func updateNavigationBar(title: String, andColor color: UIColor) {
        if (self.navigationController != nil) {
            self.navigationItem.title = title
        }
    }
    
    func navigateToView(withID vid: String, fromStoryboard sid: String = "Main") {
        let storyboard = UIStoryboard(name: sid, bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: vid)
        UIApplication.shared.keyWindow?.rootViewController = viewcontroller
    }
    
    func pushToView(withID vid: String, fromStoryboard sid: String = "Main") {
        let storyboard = UIStoryboard(name: sid, bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: vid)
        if (self.navigationController != nil) {
            self.navigationController!.pushViewController(viewcontroller, animated: true)
        } else {
            self.present(viewcontroller, animated: true, completion: nil)
        }
    }
    
    func popViewController(to vid: String? = nil, fromStoryboard sid: String? = nil){
        guard let idForViewController = vid, let idForStoryboard = sid else {
            if (self.navigationController != nil) {
                self.navigationController!.popViewController(animated: true)
            }
            return
        }
        let storyboard = UIStoryboard(name: idForStoryboard, bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: idForViewController)
        if (self.navigationController != nil) {
            self.navigationController!.popToViewController(viewcontroller, animated: true)
        }
    }
    
    func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func scrollToTop(of tableView: UITableView, completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            if tableView.visibleCells.count > 0 {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
            completion()
        }
    }
    
    func setBackground(_ imageName: String, onView view: UIView) {
        let image = UIImage(named: imageName)
        let imageView = UIImageView(frame: view.frame)
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        view.addSubview(imageView)
        view.sendSubview(toBack: imageView)
    }
    
    func setBackground(_ color: UIColor, onView view: UIView) {
        self.view.backgroundColor = color
    }
    
    func addPadding(toTextField field: UITextField, withWidth width: CGFloat) {
        let paddingLeft = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: width,
                                               height: field.frame.height))
        field.leftView = paddingLeft
        field.leftViewMode = .always
    }
    
    func storeLocalProperties(data: User, completion: @escaping () -> Void) {
        UserDefaults.standard.set(data.getUserid(), forKey: UserDefaults.UserSettings.userid)
        UserDefaults.standard.set(data.getUsername(), forKey: UserDefaults.UserSettings.username)
        UserDefaults.standard.set(true, forKey: UserDefaults.AuthenticationKeys.sessionActive)
        completion()
        
    }
    
    func destroyLocalDefaultProperties(completion: @escaping () -> Void) {
        UserDefaults.standard.set(nil, forKey: UserDefaults.UserSettings.userid)
        UserDefaults.standard.set(nil, forKey: UserDefaults.UserSettings.username)
        UserDefaults.standard.set(nil, forKey: UserDefaults.AuthenticationKeys.sessionActive)
        completion()
    }*/
    
    
}
 
