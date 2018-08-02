//
//  HelpViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/4/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import Alamofire
import DropDown

let help_cell_identifier = "HelpCell"

class HelpViewController: UIViewController {
    
    @IBOutlet var navigationViewContainer: UIView!
    @IBOutlet var sectionContainer: UIView!
    @IBOutlet var btn_Cancel: UIButton!
    @IBOutlet var btn_Submit: UIButton!
    @IBOutlet var text_TypeMessage: UITextView!
    @IBOutlet var text_Category: UITextField!
    @IBOutlet var lbl_Title: UILabel!
    
    var user: User!
    var navigation: SecondaryNavigationViewController!
    
    let ddHelpCategories = DropDown()
    var selectedHelpCategory = 0
    var helpCategoryList:HelpCategoryList = HelpCategoryList(JSONString:"{}")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SSAnalytics.reportUserAction(action_type: SSAnalytics.AnalyticsActionType.HELP)
        setupInterface()
        let parameters: Parameters = ["action": "getHelpCategories"]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseString { response in
            print("Response: \(response.result.value!)")
            if let strList = response.result.value{
                self.helpCategoryList = HelpCategoryList(JSONString: strList)!
                for helpCategory:HelpCategory in self.helpCategoryList.helpcategoryList{
                    self.ddHelpCategories.dataSource.append(helpCategory.getHelpcategoryname())
                }
                self.ddHelpCategories.anchorView = self.text_Category
                self.ddHelpCategories.selectionAction = { [unowned self] (index: Int, item: String) in
                    print("Selected item: \(item) at index: \(index)")
                    self.selectedHelpCategory = index
                    self.text_Category.text = item
                }
                
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submit(_ sender: UIButton) {
        
        
        let parameters: Parameters = ["action": "sendHelpEmail",
                                      "subject": text_Category.text!,
                                      "message": text_TypeMessage.text!
                                      
                                      ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            
            
            let sb = UIStoryboard(name: "Main",
                                  bundle: nil)
            guard
                let vc = sb.instantiateViewController(withIdentifier: "ResendPasswordPopOverViewController") as? ResendPasswordPopOverViewController
                else
            {
                return
            }
            //vc.user = self.user
            vc.text = help_popover_text
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true,
                completion: nil)
    }
    
}

extension HelpViewController {
    func setupInterface() {
        text_Category.delegate = self
        text_Category.textColor = UIColor.AppColors.beige
        text_TypeMessage.delegate = self
        
        setVCBackgroundImageToView(image: dashboard_background_image)
        
        navigation = SecondaryNavigationViewController()
        addChildViewController(navigation)
        navigationViewContainer.addSubview(navigation.view)
        didMove(toParentViewController: navigation)
        navigation.delegate = self
        navigation.titleForView = "HELP"
        
      
        lbl_Title.textColor = UIColor.AppColors.beige
        let userName = Utils().getPermanentString(keyName: "USER_NAME")
        lbl_Title.text = String(format: "How can we help you, %@?", userName)
        
        sectionContainer.backgroundColor = UIColor.AppColors.purple
        
        btn_Cancel.layer.cornerRadius = CGFloat(btn_radius)
        btn_Cancel.layer.borderColor = UIColor.AppColors.beige.cgColor
        btn_Cancel.layer.borderWidth = CGFloat(btn_border_width)
        btn_Cancel.backgroundColor = UIColor.clear
        btn_Cancel.setTitleColor(UIColor.AppColors.beige,
                                 for: .normal)
        btn_Cancel.setTitle(registration_cancel.uppercased(),
                            for: .normal)
        
        btn_Submit.layer.cornerRadius = CGFloat(btn_radius)
        btn_Submit.layer.borderColor = UIColor.AppColors.black.cgColor
        btn_Submit.layer.borderWidth = CGFloat(btn_border_width)
        btn_Submit.backgroundColor = UIColor.AppColors.beige
        btn_Submit.setTitleColor(UIColor.AppColors.black,
                                 for: .normal)
        btn_Submit.setTitle(registration_submit.uppercased(),
                            for: .normal)
        
        let rightInputImage = UIImage(named: "dropDownArrow")
        let rightInputImageView = UIImageView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: 32,
                                                            height: self.text_Category.frame.height))
        rightInputImageView.image = rightInputImage
        rightInputImageView.contentMode = .center
        self.text_Category.rightViewMode = .always
        self.text_Category.rightView = rightInputImageView
    }
    
   
    
    
    
   
}

extension HelpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == text_Category{
            ddHelpCategories.show()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        return true
    }
}

extension HelpViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == text_TypeMessage{
            if textView.text == "Type in your message here..."{
                textView.text = ""
            }
        }
    }
}

extension HelpViewController: NavDelegate {
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
        if !(self is HelpViewController) {
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


