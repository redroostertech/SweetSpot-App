//
//  WineProfileViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/1/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit
import Alamofire
import DropDown

class WineProfileViewController: UIViewController {
    
    @IBOutlet var view_SummaryContainer: UIView!
    @IBOutlet var lbl_Type: UILabel!
    @IBOutlet var btn_EditSummary: UIButton!
    @IBOutlet var lbl_WineCategory: UILabel!
    @IBOutlet var lbl_WinePricing: UILabel!
    @IBOutlet var lbl_WineType: UILabel!
    @IBOutlet var lbl_Category: UILabel!
    @IBOutlet var lbl_Pricing: UILabel!
    @IBOutlet var lbl_WType: UILabel!
    @IBOutlet var text_Gender: UITextField!
    @IBOutlet var text_MaritalStatus: UITextField!
    @IBOutlet var text_AgeRange: UITextField!
    @IBOutlet var text_SalaryRange: UITextField!
    @IBOutlet var lbl_Gender: UILabel!
    @IBOutlet var lbl_MaritalStatus: UILabel!
    @IBOutlet var lbl_AgeRange: UILabel!
    @IBOutlet var lbl_SalaryRange: UILabel!
    @IBOutlet var btn_SaveChanges: UIButton!
    @IBOutlet var btn_Cancel: UIButton!
    @IBOutlet var btn_Gender: UIButton!
    @IBOutlet var btn_MaritalStatus: UIButton!
    @IBOutlet var btn_AgeRange: UIButton!
    @IBOutlet var btn_SalaryRange: UIButton!
    
    var user: User?
    var btn_Save: UIButton?
    var containerViewController:ProfileContainerViewController?
    
    
    var picker: UIPickerView?
    var dropDownType: Int = 0
    var salaryList:SalaryRangeList = SalaryRangeList(JSONString: "{}")!
    var genderList:GenderList = GenderList(JSONString: "{}")!
    var ageRangeList:AgeRangeList = AgeRangeList(JSONString: "{}")!
    var maritalStatusList:MaritalStatusList = MaritalStatusList(JSONString: "{}")!
    
    var selectedSalary = 0
    var selectedGender = 0
    var selectedAge = 0
    var selectedMarital = 0
    
    
    let ddSalaryTypes = DropDown()
    let ddGenderTypes = DropDown()
    let ddAgeTypes = DropDown()
    let ddMaritalTypes = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text_Gender.delegate = self
        text_MaritalStatus.delegate = self
        text_AgeRange.delegate = self
        text_SalaryRange.delegate = self
        
        self.view.backgroundColor = .clear
        
        self.view_SummaryContainer.backgroundColor = UIColor.AppColors.plum
        lbl_Type.textColor = UIColor.AppColors.beige
        lbl_WineCategory.textColor = UIColor.AppColors.grey
        lbl_WinePricing.textColor = UIColor.AppColors.grey
        lbl_WineType.textColor = UIColor.AppColors.grey
        lbl_Category.textColor = UIColor.AppColors.beige
        lbl_Pricing.textColor = UIColor.AppColors.beige
        lbl_WType.textColor = UIColor.AppColors.beige
        
        //lbl_WinePricing.addTopBottomHorizontalLines()
        //lbl_WineCategory.addTopBottomHorizontalLines()
        //lbl_WineType.addTopBottomHorizontalLines()
        
        lbl_Gender.textColor = UIColor.AppColors.beige
        lbl_MaritalStatus.textColor = UIColor.AppColors.beige
        lbl_AgeRange.textColor = UIColor.AppColors.beige
        lbl_SalaryRange.textColor = UIColor.AppColors.beige
        
        btn_EditSummary.backgroundColor = UIColor.clear
        btn_EditSummary.setTitleColor(UIColor.AppColors.beige,
                                      for: .normal)
        btn_EditSummary.setTitle(profile_edit.uppercased(),
                                 for: .normal)
        
        btn_Cancel.layer.cornerRadius = CGFloat(btn_radius)
        btn_Cancel.layer.borderColor = UIColor.AppColors.beige.cgColor
        btn_Cancel.layer.borderWidth = CGFloat(btn_border_width)
        btn_Cancel.backgroundColor = UIColor.clear
        btn_Cancel.setTitleColor(UIColor.AppColors.beige,
                                 for: .normal)
        btn_Cancel.setTitle(registration_cancel.uppercased(),
                            for: .normal)
        
        btn_SaveChanges.layer.cornerRadius = CGFloat(btn_radius)
        btn_SaveChanges.layer.borderColor = UIColor.AppColors.black.cgColor
        btn_SaveChanges.layer.borderWidth = CGFloat(btn_border_width)
        btn_SaveChanges.backgroundColor = UIColor.AppColors.beige
        btn_SaveChanges.setTitleColor(UIColor.AppColors.black,
                                      for: .normal)
        btn_SaveChanges.setTitle(profile_save_changes.uppercased(),
                                 for: .normal)
        
        for i in 1...5{
            loadList(list_id: i)
        }
        loadCustomer()
        SSAnalytics.reportUserAction(action_type: SSAnalytics.AnalyticsActionType.PROFILE_WINE_PROFILE)
    }
    
    func loadCustomer(){
        let parameters: Parameters = ["action": "getCustomerByID",
                                      "customer_id":Utils().getPermanentString(keyName: "CUSTOMER_ID")
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            
            let jsonValues = response.result.value as! [String:Any]
            
            let status = jsonValues["status"] as? Int
            if status != 1{
                return
            }
            let data = jsonValues["data"] as! [String:Any]
            if let theJSONData = try? JSONSerialization.data( withJSONObject: data, options: []) {
                let theJSONText = String(data: theJSONData,
                                         encoding: .ascii)
                print("JSON string = \(theJSONText!)")
                
                if let customer = Customer(JSONString: theJSONText!){
                    
                    if let gender_name = customer.gender_name{
                        self.text_Gender.text = gender_name
                    }
                    if let age_name = customer.age_name{
                        self.text_AgeRange.text = age_name
                    }
                    if let salary_name = customer.salary_name{
                        self.text_SalaryRange.text = salary_name
                    }
                    if let marital_name = customer.marital_name{
                        self.text_MaritalStatus.text = marital_name
                    }
                    if let wine_color_name = customer.wine_color_name{
                        self.lbl_WineCategory.text = wine_color_name
                        //self.lbl_WineCategory.sizeToFit()
                    }
                    if let wine_pricing_name = customer.wine_pricing_name{
                        self.lbl_WinePricing.text = wine_pricing_name
                        //self.lbl_WinePricing.sizeToFit()
                    }
                    if let wine_selected_name = customer.wine_selected_name{
                        self.lbl_WineType.text = wine_selected_name
                        //self.lbl_WineType.sizeToFit()
                    }
                    if let wine_profile_name = customer.wine_profile_name{
                        self.lbl_Type.text = wine_profile_name
                    }
                    self.selectedSalary = customer.getSalaryrangeid()
                    self.selectedAge = customer.getAgerangeid()
                    self.selectedGender = customer.getGenderid()
                    self.selectedMarital = customer.getMaritalstatusid()
                }
            }
        }
    }
    
    func loadList(list_id:Int){
        var action = ""
        switch(list_id){
        case 1:
            action = "getGenders"
            break
        case 2:
            action = "getMaritalStatuses"
            break
        case 3:
            action = "getAgeRanges"
            break
        case 4:
            action = "getSalaryRanges"
            break
        default:
            break
        }
        let parameters: Parameters = ["action": action]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseString { response in
            print("Response: \(response.result.value!)")
            switch(list_id){
            case 1:
                self.genderList = GenderList(JSONString: response.result.value!)!
                for gender:Gender in self.genderList.genderList{
                   self.ddGenderTypes.dataSource.append(gender.getGendername())
                }
                self.ddGenderTypes.anchorView = self.text_Gender
                self.ddGenderTypes.selectionAction = { [unowned self] (index: Int, item: String) in
                    print("Selected item: \(item) at index: \(index)")
                    self.text_Gender.text = item
                    self.selectedGender = self.genderList.genderList[index].getGenderid()
                }
                break
            case 2:
                self.maritalStatusList = MaritalStatusList(JSONString: response.result.value!)!
                for maritalStatus:MaritalStatus in self.maritalStatusList.maritalstatusList{
                    self.ddMaritalTypes.dataSource.append(maritalStatus.getMaritalstatusname())
                }
                self.ddMaritalTypes.anchorView = self.text_MaritalStatus
                self.ddMaritalTypes.selectionAction = { [unowned self] (index: Int, item: String) in
                    print("Selected item: \(item) at index: \(index)")
                    self.text_MaritalStatus.text = item
                    self.selectedMarital = self.maritalStatusList.maritalstatusList[index].getMaritalstatusid()
                }
                break
            case 3:
                self.ageRangeList = AgeRangeList(JSONString: response.result.value!)!
                for ageRange:AgeRange in self.ageRangeList.agerangeList{
                    self.ddAgeTypes.dataSource.append(ageRange.getAgerangename())
                }
                self.ddAgeTypes.anchorView = self.text_AgeRange
                self.ddAgeTypes.selectionAction = { [unowned self] (index: Int, item: String) in
                    print("Selected item: \(item) at index: \(index)")
                    self.text_AgeRange.text = item
                    self.selectedAge = self.ageRangeList.agerangeList[index].getAgerangeid()
                }
                break
            case 4:
                self.salaryList = SalaryRangeList(JSONString: response.result.value!)!
                for salaryRange:SalaryRange in self.salaryList.salaryrangeList{
                    self.ddSalaryTypes.dataSource.append(salaryRange.getSalaryrangename())
                }
                self.ddSalaryTypes.anchorView = self.text_SalaryRange
                self.ddSalaryTypes.selectionAction = { [unowned self] (index: Int, item: String) in
                    print("Selected item: \(item) at index: \(index)")
                    self.text_SalaryRange.text = item
                    self.selectedSalary = self.salaryList.salaryrangeList[index].getSalaryrangeid()
                }
                break
            default:
                break
            }
            
            
        } //alamofire
    }
    
    func goDashboard(){
        containerViewController?.doDismiss()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startQuestionaire(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main",
                              bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "QuestionaireViewController") as? QuestionaireViewController else {
            return
        }
        vc.user = self.user
        vc.startingViewController = self
        show(vc, sender: self)
        
    }
    
    @IBAction func saveChanges(_ sender: UIButton) {
        SSAnalytics.reportUserAction(action_type: SSAnalytics.AnalyticsActionType.PROFILE_WINE_PROFILE_SAVECHANGES)
       
        let parameters: Parameters = ["action": "updateUserProfile",
                                      "customer_id":Utils().getPermanentString(keyName: "CUSTOMER_ID"),
                                      "gender_id":"\(selectedGender)",
            "marital_status_id":"\(selectedMarital)",
            "salary_range_id":"\(selectedSalary)",
            "age_range_id":"\(selectedAge)"
            
        ]
        Alamofire.request(AppConstants.RM_SERVER_URL, parameters: parameters, encoding: URLEncoding.default).responseString { response in
            self.goDashboard()
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        SSAnalytics.reportUserAction(action_type: SSAnalytics.AnalyticsActionType.PROFILE_WINE_PROFILE_CANCEL)
        //        self.dismiss(animated: true,
        //                     completion: nil)
        goDashboard()
    }
    
    @IBAction func editField(_ sender: UIButton) {
        switch sender {
        case self.btn_Gender:
            print("First Name")
            self.showSaveButtonOn(sender: sender)
        case self.btn_MaritalStatus:
            print("Last Name")
            self.showSaveButtonOn(sender: sender)
        case self.btn_AgeRange:
            print("Zip Code")
            self.showSaveButtonOn(sender: sender)
        case self.btn_SalaryRange:
            print("Email Address")
            self.showSaveButtonOn(sender: sender)
        default:
            print("None")
        }
    }
    func showSaveButtonOn(sender: UIButton) {
        if let btn_Save = self.btn_Save {
            btn_Save.removeFromSuperview()
        }
        self.btn_Save = UIButton(frame: CGRect(x: sender.frame.origin.x - 50,
                                               y: sender.frame.origin.y + sender.frame.height + 16,
                                               width: 100,
                                               height: 30))
        
        self.btn_Save?.layer.cornerRadius = CGFloat(self.btn_Save!.frame.height / 2)
        self.btn_Save?.layer.borderColor = UIColor.AppColors.black.cgColor
        self.btn_Save?.layer.borderWidth = CGFloat(btn_border_width)
        self.btn_Save?.backgroundColor = UIColor.AppColors.beige
        self.btn_Save?.setTitleColor(UIColor.AppColors.black,
                                     for: .normal)
        self.btn_Save?.setTitle("Save".uppercased(),
                                for: .normal)
        
        self.view.addSubview(self.btn_Save!)
    }
}

extension WineProfileViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case text_MaritalStatus:
            
            self.ddMaritalTypes.show()
            self.view.endEditing(true)
        case text_AgeRange:
            self.dropDownType = 3
           self.ddAgeTypes.show()
            self.view.endEditing(true)
        case text_SalaryRange:
            self.dropDownType = 4
           self.ddSalaryTypes.show()
            self.view.endEditing(true)
        case text_Gender:
            self.dropDownType = 1
           self.ddGenderTypes.show()
            self.view.endEditing(true)
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}




extension UILabel {
    func addTopBottomHorizontalLines() {
        let hr_top = UIView(frame: CGRect(x: self.frame.origin.x,
                                          y: self.frame.origin.y + 1,
                                          width: self.frame.width,
                                          height: 1))
        hr_top.backgroundColor = .white
        let hr_bottom = UIView(frame: CGRect(x: self.frame.origin.x,
                                             y: self.frame.origin.y - 1,
                                             width: self.frame.width,
                                             height: 1))
        hr_bottom.backgroundColor = .white
        self.addSubview(hr_top)
        self.addSubview(hr_bottom)
    }
}

